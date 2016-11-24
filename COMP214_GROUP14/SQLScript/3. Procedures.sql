
--PROCEDURES ====================================================================================

--    insertStudent(fname,lname), completed credits insert to 0 by default
--     -creates new student, output studentID
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
  Deletes records from courseinstructors for courses this instructor is teaching.
  Then removes this instructor from the instructors table.
  Finally, the number of courses affected by this delete is returned as an out
  parameter.
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
  Creates course with input title, credits and deptid which corresponds
  to the input dept name. if dept name doese not exist, will call function
  to create new department and insert into that.
*/
CREATE OR REPLACE PROCEDURE create_course_sp (
    v_title      IN sc_courses.title%type,
    v_credit     IN sc_courses.credits%type,
    v_deptname   IN sc_departments.name%type,
    v_instructorid IN number
)
    AS
BEGIN
    INSERT INTO sc_courses VALUES (
        sc_course_id_seq.NEXTVAL,
        v_title,
        v_credit,
        'N',
        getdeptid_fn(v_deptname)
    );
    INSERT INTO sc_courseinstructors values (
      sc_course_id_seq.currval,
      v_instructorid);
END;
