
--TRIGGERS ======================================================================================

--Trigger to set final credit for student for a perticular course:
--This Trigger is called when the user sets course completion to "Y".
--It will update student course credit after setting course completion to "Y".
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
-- This trigger will call the delete command to remove enrollment of student to a course.
-- After course is removed from student record it will delete the student 

CREATE OR REPLACE TRIGGER delete_student_trg BEFORE
    DELETE ON sc_students
    FOR EACH ROW
BEGIN
    DELETE FROM sc_courseenrollments WHERE
        student_id =:old.student_id;

END;
