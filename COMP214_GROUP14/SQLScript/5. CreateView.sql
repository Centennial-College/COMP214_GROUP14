
  --VIEWS =====================================================================================

 -- This view will display course information in a Table
 -- Example :: Course Title || Department Name || Credits || Completed || Instructor Name

CREATE OR REPLACE VIEW vw_course AS
    SELECT
        c.course_id,
        c.title title,
        c.dept_id,
        d.name dept_name,
        c.credits credits,
        c.completed completed,
        i.fname
         ||  ' '
         ||  i.lname instructorname,
        (
            SELECT
                COUNT(*)
            FROM
                sc_courseenrollments e
            WHERE
                e.course_id = c.course_id
        ) AS numberofstudents
    FROM
        sc_courses c,
        sc_departments d,
        sc_courseinstructors ci,
        sc_instructors i
    WHERE
        c.dept_id = d.dept_id
    AND
        c.course_id = ci.course_id
    AND
        ci.instructor_id = i.instructor_id;
 
   
 -- This view will display Course Enrollmemnt information in a Table form
 -- Example :: Course Title || Completed 

CREATE OR REPLACE VIEW vw_courseenroll AS
    SELECT
        c.course_id course_id,
        s.student_id student_id,
        c.title title,
        c.completed completed,
        isstudentenrolledcourse(s.student_id,c.course_id) isenrolled
    FROM
        sc_courses c,
        sc_students s;


 -- This view will display instructor information in a Table form
 -- Example :: Instructor First Name || Instructor Last Name

CREATE OR REPLACE VIEW vw_instructor AS
    SELECT
        instructor_id,
        fname,
        lname,
        (
            SELECT
                COUNT(*)
            FROM
                sc_courseinstructors c
            WHERE
                c.instructor_id = i.instructor_id
        ) AS numberofcourses
    FROM
        sc_instructors i;
        
 -- This view will display Student information in a Table form
 -- Example :: Student First Name || Student Last Name || Completed Credits

CREATE OR REPLACE VIEW vw_student
AS   
       SELECT 
       STUDENT_ID, 
       FNAME, 
       LNAME, 
       COMPLETED_CREDITS, 
       (select count(*) from sc_courseenrollments e where e.student_id=s.student_id) CoursesTotal,
       (select count(*) from sc_courseenrollments e, sc_courses c where c.course_id=e.course_id and  e.student_id=s.student_id and c.COMPLETED='Y') CoursesCompletd,
       (select count(*) from sc_courseenrollments e, sc_courses c where c.course_id=e.course_id and  e.student_id=s.student_id and c.COMPLETED='Y') CoursesNoCompletd
       FROM SC_STUDENTS s;
