
--TRIGGERS ======================================================================================
--click button > update course set status to 'Y' . after update, 
--update students complete creditscreate or replace trigger complete_course_trg
CREATE OR REPLACE TRIGGER complete_course_trg AFTER
    UPDATE OF completed ON sc_courses
    FOR EACH ROW
    WHEN ( new.completed = 'Y' )
DECLARE
    CURSOR enrolledstudents_cur IS
        SELECT
            student_id
        FROM
            sc_courseenrollments
         WHERE
            course_id =:old.course_id;

BEGIN
    FOR enrolledstudent_rec IN enrolledstudents_cur LOOP
        UPDATE sc_students
            SET
                completed_credits = completed_credits +:old.credits
        WHERE
            student_id = enrolledstudent_rec.student_id;

    END LOOP;
END;

--Trigger for delete student:
--DELETE_STUDENT_TRG
-- 
--Before deleting a student record
--Delete this student records in sc_courseenrollments table

CREATE OR REPLACE TRIGGER delete_student_trg BEFORE
    DELETE ON sc_students
    FOR EACH ROW
BEGIN
    DELETE FROM sc_courseenrollments WHERE
        student_id =:old.student_id;

END;
