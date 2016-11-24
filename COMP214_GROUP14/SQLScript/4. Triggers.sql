
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
