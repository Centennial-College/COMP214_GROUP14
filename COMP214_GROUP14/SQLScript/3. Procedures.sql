
/*
    @procedure insert_student_sp
    @description This procedure is called to insert students into the SC_STUDENTS
                 table. The number of completed credits will be set to 0. The other
                 data associated with the student record will be provided by the
                 input parameters.
    @param
        v_fname     IN VARCHAR2 - the first name for the new student record
        v_lname     IN VARCHAR2 - the last name for the new student record
        v_studentid OUT NUMBER  - the new student's id will be returned to the calling construct
*/
CREATE OR REPLACE procedure insert_student_sp (
    v_fname   IN VARCHAR2,
    v_lname   IN VARCHAR2,
    v_studentid out   number
) 
AS
BEGIN
    INSERT INTO sc_students VALUES (
        sc_student_id_seq.NEXTVAL,
        v_fname,
        v_lname,
        0
    );
    v_studentid := sc_student_id_seq.currval;
END;

/*
    @procedure delete_instuctor_sp
    @description This procedure is called to remove all records from the 
                 SC_COURSEINSTRUCTORS table for the courses a specific instructor
                 is teaching. 
    @param
        v_instructorid      IN NUMBER   - the id for the specific instructor
        v_affactednumber    OUT NUMBER  - the number of records removed will be returned to 
                                          the calling construct
*/
CREATE OR REPLACE PROCEDURE delete_instuctor_sp (
    v_instructorid     IN NUMBER,
    v_affactednumber   OUT NUMBER
) AS
    lv_num_courses   NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO
        v_affactednumber
    FROM
        sc_courseinstructors
    WHERE
        instructor_id = v_instructorid;

    DELETE FROM sc_courseinstructors WHERE
        instructor_id = v_instructorid;

    DELETE FROM sc_instructors WHERE
        instructor_id = v_instructorid;

END;

/*
    @procedure create_course_sp
    @description This procedure is called to create a new record to be inserted in the
                 SC_COURSES table. All of the record's data will come from the input 
                 parameters. The exception is with the department the course is associated
                 with. This procedure will attempt to find a department record associated 
                 with the the input parameter. However, if a department is not found, a 
                 new department will be created with the specified department name.
    @param
        v_title         IN SC_COURSES.TITLE%TYPE    - the title for the new course
        v_credit        IN SC_COURSES.CREDITS%TYPE  - the number of credits for the new course
        v_deptname      IN SC_DEPARTMENTS.NAME%TYPE - the name of the department the course is associated to
        v_instructorid  IN NUMBER                   - the id of the instructor who will be teaching this course
*/
CREATE OR REPLACE PROCEDURE create_course_sp (
    v_title      IN sc_courses.title%type,
    v_credit     IN sc_courses.credits%type,
    v_deptname   IN sc_departments.name%type,
    v_instructorid IN number
)
    AS
BEGIN
    -- create new course record
    INSERT INTO sc_courses VALUES (
        sc_course_id_seq.NEXTVAL,
        v_title,
        v_credit,
        'N',
        getdeptid_fn(v_deptname)
    );
    
    -- create new record in the courseinstructors table
    INSERT INTO sc_courseinstructors values (
      sc_course_id_seq.currval,
      v_instructorid);
END;

/*
    @procedure update_courseenrollments_sp
    @description This procedure is called when a student enrolls or un-enrolls from a 
                 course. If the specified student is enrolled in the selected course,
                 the student will be un-enrolled from the course. If the student is 
                 not found to be enrolled in the course, he/she will be enrolled in
                 the course.
    @param
        v_student_id    IN NUMBER   - the id for the student
        v_course_id     IN NUMBER   - the id for the course to be searched for
        v_selected      IN NUMBER   - = 1 if the course is selected
                                    - = 0 if the course is not selected
*/
CREATE OR REPLACE PROCEDURE update_courseenrollments_sp (
    v_student_id   IN NUMBER,
    v_course_id    IN NUMBER,
    v_selected     IN NUMBER
) AS
    lv_matching_records_found   NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO
        lv_matching_records_found
    FROM
        sc_courseenrollments
    WHERE
        course_id = v_course_id
    AND
        student_id = v_student_id;
  
    -- only enroll/un-enroll a student from the course if the course is 
    -- selected in the application
    IF v_selected = 1 THEN
        IF lv_matching_records_found = 0 THEN
            INSERT INTO sc_courseenrollments VALUES ( v_course_id,v_student_id );
        END IF;
        
    ELSE
        IF lv_matching_records_found = 1 THEN
            DELETE FROM sc_courseenrollments WHERE
                course_id = v_course_id
            AND
                student_id = v_student_id;

        END IF;
    END IF;

END;
