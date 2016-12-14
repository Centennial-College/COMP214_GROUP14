/*
    DROP STATEMENTS
    -----------------------------------------------------------------------
    These drop statements are run at the initial startup of the application 
    to re-initialize the tables and its related database objects (indexes
    and sequences).
*/
-- DROPPING INDEXES
DROP INDEX sc_students_fname_idx;

DROP INDEX sc_students_lname_idx;

DROP INDEX sc_instructors_fname_idx;

DROP INDEX sc_instructors_lname_idx;

-- DROPPING SEQUENCES
DROP SEQUENCE sc_student_id_seq;

DROP SEQUENCE sc_instructor_id_seq;

DROP SEQUENCE sc_department_id_seq;

DROP SEQUENCE sc_course_id_seq;

-- DROPPING TABLES
DROP TABLE sc_courseenrollments;

DROP TABLE sc_courseinstructors;

DROP TABLE sc_courses;

DROP TABLE sc_instructors;

DROP TABLE sc_departments;

DROP TABLE sc_students;

/*
    TABLES CREATION
    -----------------------------------------------------------------------
    The following DDL statements create the tables required for this 
    application.
*/
-- STUDENTS TABLE
CREATE TABLE sc_students (
    student_id          int PRIMARY KEY,
    fname               VARCHAR2(50) NOT NULL,
    lname               VARCHAR2(50) NOT NULL,
    completed_credits   NUMBER(4,1)
);

-- INSTRUCTORS TABLE
CREATE TABLE sc_instructors (
    instructor_id   int PRIMARY KEY,
    fname           VARCHAR2(50) NOT NULL,
    lname           VARCHAR2(50) NOT NULL
);

-- DEPARTMENTS TABLE
CREATE TABLE sc_departments (
    dept_id   int PRIMARY KEY,
    name      VARCHAR2(50) NOT NULL
);

-- COURSES TABLE
CREATE TABLE sc_courses (
    course_id   int PRIMARY KEY,
    title       VARCHAR2(50) NOT NULL,
    credits     int NOT NULL,
    completed   VARCHAR2(1) DEFAULT 'N',
    dept_id     int NOT NULL,
    CONSTRAINT fk_department_id FOREIGN KEY ( dept_id )
        REFERENCES sc_departments ( dept_id )
);

-- COURSEENROLLMENTS TABLE -> bridge entity between STUDENTS and COURSES
-- This is required because there is a many to many relationship between
-- STUDENTS and COURSES
CREATE TABLE sc_courseenrollments (
    course_id    int NOT NULL,
    student_id   int NOT NULL,
    CONSTRAINT fk_courseid FOREIGN KEY ( course_id )
        REFERENCES sc_courses ( course_id ),
    CONSTRAINT pk_enrollment PRIMARY KEY ( course_id,student_id ),
    CONSTRAINT fk_studentid FOREIGN KEY ( student_id )
        REFERENCES sc_students ( student_id )
);

-- COURSEINSTRUCTORS TABLE -> bridge entity between INSTRUCTORS and COURSES
-- This is required because there is a many to many relationship between
-- INSTRUCTORS and COURSES
CREATE TABLE sc_courseinstructors (
    course_id       int NOT NULL,
    instructor_id   int NOT NULL,
    CONSTRAINT pk_courseinstructor PRIMARY KEY ( course_id,instructor_id ),
    CONSTRAINT fk_courseinstructors_cid FOREIGN KEY ( course_id )
        REFERENCES sc_courses ( course_id ),
    CONSTRAINT fk_courseinstructors_iid FOREIGN KEY ( instructor_id )
        REFERENCES sc_instructors ( instructor_id )
);

/*
    SEQUENCES CREATION
    -----------------------------------------------------------------------
    The following DDL statements create the sequences required for this 
    application. These sequences will be used to generate the primary key
    values for the STUDENTS, INSTRUCTORS, DEPARTMENTS, and COURSES table.
*/

-- sequence for STUDENTS
CREATE SEQUENCE sc_student_id_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

-- sequence for INSTRUCTORS
CREATE SEQUENCE sc_instructor_id_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

-- sequence for DEPARTMENTS
CREATE SEQUENCE sc_department_id_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

-- sequence for COURSES
CREATE SEQUENCE sc_course_id_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

/*
    DATA INSERTION
    -----------------------------------------------------------------------
    The following DML statements insert sample data for the initial startup
    of this application
*/

-- inserting into DEPARTMENTS
INSERT INTO sc_departments VALUES ( sc_department_id_seq.NEXTVAL,'Software Engineering' );

INSERT INTO sc_departments VALUES ( sc_department_id_seq.NEXTVAL,'Chemical Engineering' );

INSERT INTO sc_departments VALUES ( sc_department_id_seq.NEXTVAL,'Civil Engineering' );

INSERT INTO sc_departments VALUES ( sc_department_id_seq.NEXTVAL,'Math' );

INSERT INTO sc_departments VALUES ( sc_department_id_seq.NEXTVAL,'History' );

-- inserting into INSTRUCTORS
INSERT INTO sc_instructors VALUES (
    sc_instructor_id_seq.NEXTVAL,
    'Peter',
    'Smith'
);

INSERT INTO sc_instructors VALUES (
    sc_instructor_id_seq.NEXTVAL,
    'Waterloo',
    'Benjimi'
);

INSERT INTO sc_instructors VALUES (
    sc_instructor_id_seq.NEXTVAL,
    'Alex',
    'Wang'
);

INSERT INTO sc_instructors VALUES (
    sc_instructor_id_seq.NEXTVAL,
    'Luke',
    'Lu'
);

INSERT INTO sc_instructors VALUES (
    sc_instructor_id_seq.NEXTVAL,
    'Simong',
    'Kichen'
);

INSERT INTO sc_instructors VALUES (
    sc_instructor_id_seq.NEXTVAL,
    'Bella',
    'Carly'
);

INSERT INTO sc_instructors VALUES (
    sc_instructor_id_seq.NEXTVAL,
    'Katty',
    'Smith'
);

INSERT INTO sc_instructors VALUES (
    sc_instructor_id_seq.NEXTVAL,
    'Jimi',
    'Hee'
);

INSERT INTO sc_instructors VALUES (
    sc_instructor_id_seq.NEXTVAL,
    'Rose',
    'Zhang'
);

INSERT INTO sc_instructors VALUES (
    sc_instructor_id_seq.NEXTVAL,
    'Dynial',
    'Watte'
);

COMMIT;

-- inserting into COURSES
INSERT INTO sc_courses VALUES (
    sc_course_id_seq.NEXTVAL,
    'C# Programming',
    3,
    'N',
    1
);

INSERT INTO sc_courses VALUES (
    sc_course_id_seq.NEXTVAL,
    'Java Programming',
    3,
    'N',
    1
);

INSERT INTO sc_courses VALUES (
    sc_course_id_seq.NEXTVAL,
    'Python Programming',
    3,
    'N',
    3
);

INSERT INTO sc_courses VALUES (
    sc_course_id_seq.NEXTVAL,
    'Math 185',
    3,
    'N',
    4
);

INSERT INTO sc_courses VALUES (
    sc_course_id_seq.NEXTVAL,
    'Canada History',
    3,
    'N',
    5
);

INSERT INTO sc_courses VALUES (
    sc_course_id_seq.NEXTVAL,
    'Irrational',
    3,
    'N',
    2
);

INSERT INTO sc_courses VALUES (
    sc_course_id_seq.NEXTVAL,
    'Enviroment',
    3,
    'N',
    2
);

INSERT INTO sc_courses VALUES (
    sc_course_id_seq.NEXTVAL,
    'Construction',
    3,
    'N',
    3
);

INSERT INTO sc_courses VALUES (
    sc_course_id_seq.NEXTVAL,
    'Web Developer',
    3,
    'N',
    1
);

INSERT INTO sc_courses VALUES (
    sc_course_id_seq.NEXTVAL,
    'Database Concept',
    3,
    'N',
    1
);

-- inserting into COURSEINSTRUCTORS
INSERT INTO sc_courseinstructors VALUES ( 1,1 );

INSERT INTO sc_courseinstructors VALUES ( 2,2 );

INSERT INTO sc_courseinstructors VALUES ( 3,3 );

INSERT INTO sc_courseinstructors VALUES ( 4,4 );

INSERT INTO sc_courseinstructors VALUES ( 5,5 );

INSERT INTO sc_courseinstructors VALUES ( 6,6 );

INSERT INTO sc_courseinstructors VALUES ( 7,7 );

INSERT INTO sc_courseinstructors VALUES ( 8,8 );

INSERT INTO sc_courseinstructors VALUES ( 9,9 );

INSERT INTO sc_courseinstructors VALUES ( 10,10 );

-- inserting into STUDENTS
INSERT INTO sc_students VALUES (
    sc_student_id_seq.NEXTVAL,
    'Luke',
    'Lu',
    0
);

INSERT INTO sc_students VALUES (
    sc_student_id_seq.NEXTVAL,
    'Kevin',
    'Ma',
    0
);

INSERT INTO sc_students VALUES (
    sc_student_id_seq.NEXTVAL,
    'Kareem',
    'Marzouk ',
    0
);

INSERT INTO sc_students VALUES (
    sc_student_id_seq.NEXTVAL,
    'Bhavin',
    'Master ',
    0
);

-- inserting into COURSEENROLLMENTS
INSERT INTO sc_courseenrollments VALUES ( 2,1 );

INSERT INTO sc_courseenrollments VALUES ( 3,1 );

INSERT INTO sc_courseenrollments VALUES ( 4,1 );

INSERT INTO sc_courseenrollments VALUES ( 5,1 );

INSERT INTO sc_courseenrollments VALUES ( 6,1 );

INSERT INTO sc_courseenrollments VALUES ( 7,1 );

INSERT INTO sc_courseenrollments VALUES ( 8,1 );

INSERT INTO sc_courseenrollments VALUES ( 9,1 );

COMMIT;

/*
    INDEXES
    -----------------------------------------------------------------------
    The following DDL statements are used to create the indexes required for
    this application. These indexes improve the speed of querying the 
    STUDENTS and INSTRUCTORS tables.
*/

-- indexes associated with the STUDENTS table
CREATE INDEX sc_students_fname_idx ON
    sc_students ( fname );

CREATE INDEX sc_students_lname_idx ON
    sc_students ( lname );

-- indexes associated with the INSTRUCTORS table
CREATE INDEX sc_instructors_fname_idx ON
    sc_instructors ( fname );

CREATE INDEX sc_instructors_lname_idx ON
    sc_instructors ( lname );


