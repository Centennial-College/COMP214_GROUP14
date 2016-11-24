
--FUNCTIONS =====================================================================================
--    getDeptId(name)
--      -if name exist return the id
--      -else create new department and return new id
CREATE OR REPLACE FUNCTION getdeptid_fn (
    v_deptname   IN VARCHAR2
) RETURN NUMBER AS
    lv_deptid  number;
BEGIN
    SELECT
        count(*)
    INTO
        lv_deptid
    FROM
        sc_departments
    WHERE
        name = v_deptname;
 
    IF lv_deptid = 0 THEN
        INSERT INTO sc_departments VALUES ( sc_department_id_seq.NEXTVAL,v_deptname );
        lv_deptid := sc_department_id_seq.currval;
    ELSE
        SELECT dept_id 
        INTO lv_deptid
        FROM sc_departments
        WHERE name=v_deptname;
    END IF;

    RETURN lv_deptid;
END;


--Parameters:

--IN Course_ID

--IN Student_ID

--RETURN 1,the student is enrolling the course

--RETURN 0,the student is not enrolling the course

CREATE OR REPLACE FUNCTION isstudentenrolledcourse (
    v_student_id   IN NUMBER,
    v_course_id    IN NUMBER
) RETURN NUMBER AS
    v_count   NUMBER(1);
BEGIN
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

    RETURN v_count;
END;
