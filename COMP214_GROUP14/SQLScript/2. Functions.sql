
/*
    @function getdeptid_fn
    @description This function returns the deptid associated with the passed in dept name.
                 If there is no deptid found, a new department is created and the new deptid 
                 is returned.
    @param
        v_deptname  VARCHAR2    - the name of the department you are looking for
    @return
        lv_deptid   NUMBER      - the deptid associated with the v_deptname
*/
CREATE OR REPLACE FUNCTION getdeptid_fn (
    v_deptname   IN VARCHAR2
) RETURN NUMBER AS
    lv_deptid  number;
BEGIN
    -- searches the SC_DEPARTMENTS table to see if there is a department with the parameter's
    -- dept. name
    SELECT
        count(*)
    INTO
        lv_deptid
    FROM
        sc_departments
    WHERE
        name = v_deptname;
 
    -- if there were no departments found, insert a new department record into the 
    -- SC_DEPARTMENTS table
    IF lv_deptid = 0 THEN
        INSERT INTO sc_departments VALUES ( sc_department_id_seq.NEXTVAL,v_deptname );
        
        -- Assign the new department id to the local variable
        lv_deptid := sc_department_id_seq.currval;
        
    -- otherwise, select the deptid from the SC_DEPARTMENTS table for the associated
    -- department record
    ELSE
        SELECT dept_id 
        INTO lv_deptid
        FROM sc_departments
        WHERE name=v_deptname;
    END IF;

    -- return the department id associated with the parameter department name
    RETURN lv_deptid;
END;

/*
    @function isstudentenrolledcourse
    @description This function checks whether a specific student is enrolled in a particular
                 course.
    @param
        v_student_id    NUMBER  - the id of the student you are looking for
        v_course_id     NUMBER  - the id of the course you are looking for
    @return
        v_count         NUMBER  - = 1 if the student is enrolled in the course
                                - = 0 if the student is not enrolled in the course
*/
CREATE OR REPLACE FUNCTION isstudentenrolledcourse (
    v_student_id   IN NUMBER,
    v_course_id    IN NUMBER
) RETURN NUMBER AS
    v_count   NUMBER(1);
BEGIN
    -- queries the SC_COURSEENROLLMENTS table to see if the student is enrolled in the
    -- specific course
    SELECT
        COUNT(*)
    INTO
        v_count
    FROM
        sc_courseenrollments
    WHERE
        course_id = v_course_id
    AND
        student_id = v_student_id;

    -- will only return 1 or 0 because the student cannot be enrolled more than once
    -- in the same course
    RETURN v_count;
END;
