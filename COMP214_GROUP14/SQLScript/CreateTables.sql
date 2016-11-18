DROP SEQUENCE sc_student_id_seq;

DROP SEQUENCE sc_instructor_id_seq;

DROP SEQUENCE sc_department_id_seq;

DROP SEQUENCE sc_course_id_seq;

DROP TABLE sc_courseenrollments;

DROP TABLE sc_courseinstructors;

DROP TABLE sc_courses;

DROP TABLE sc_instructors;

DROP TABLE sc_departments;

DROP TABLE sc_students;

--TABLES ====================================================================================

CREATE TABLE sc_students (
    student_id          int PRIMARY KEY,
    fname               VARCHAR2(50) NOT NULL,
    lname               VARCHAR2(50) NOT NULL,
    completed_credits   NUMBER(4,1)
);

CREATE TABLE sc_instructors (
    instructor_id   int PRIMARY KEY,
    fname           VARCHAR2(50) NOT NULL,
    lname           VARCHAR2(50) NOT NULL
);

CREATE TABLE sc_departments (
    dept_id   int PRIMARY KEY,
    name      VARCHAR2(50) NOT NULL
);

CREATE TABLE sc_courses (
    course_id       int PRIMARY KEY,
    title           VARCHAR2(50) NOT NULL,
    credits         int NOT NULL,
    completed        VARCHAR2(1) default 'N',
    dept_id         int NOT NULL,
    CONSTRAINT fk_department_id FOREIGN KEY ( dept_id )
        REFERENCES sc_departments ( dept_id )
 
);

CREATE TABLE sc_courseenrollments (
    course_id    int NOT NULL,
    student_id   int NOT NULL,
    CONSTRAINT fk_courseid FOREIGN KEY ( course_id )
        REFERENCES sc_courses ( course_id ),
    CONSTRAINT pk_enrollment PRIMARY KEY ( course_id,student_id ),
    CONSTRAINT fk_studentid FOREIGN KEY ( student_id )
        REFERENCES sc_students ( student_id )
);

CREATE TABLE sc_courseinstructors (
    course_id       int NOT NULL,
    instructor_id   int NOT NULL,
    CONSTRAINT pk_courseinstructor PRIMARY KEY ( course_id,instructor_id ),
    CONSTRAINT fk_courseinstructors_cid FOREIGN KEY ( course_id )
        REFERENCES sc_courses ( course_id ),
    CONSTRAINT fk_courseinstructors_iid FOREIGN KEY ( instructor_id )
        REFERENCES sc_instructors ( instructor_id )
);

--SEQUENCES ====================================================================================

CREATE SEQUENCE sc_student_id_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

CREATE SEQUENCE sc_instructor_id_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

CREATE SEQUENCE sc_department_id_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

CREATE SEQUENCE sc_course_id_seq START WITH 1 INCREMENT BY 1 NOCYCLE NOCACHE;

--INSERT DATA =======================================================================================
INSERT INTO sc_departments values (sc_department_id_seq.nextval, 'Software Engineering');
INSERT INTO sc_departments values (sc_department_id_seq.nextval, 'Chemical Engineering');
INSERT INTO sc_departments values (sc_department_id_seq.nextval, 'Civil Engineering');
INSERT INTO sc_departments values (sc_department_id_seq.nextval, 'Math');
INSERT INTO sc_departments values (sc_department_id_seq.nextval, 'History');

INSERT INTO sc_instructors values (sc_instructor_id_seq.nextval, 'Peter','Smith');
INSERT INTO sc_instructors values (sc_instructor_id_seq.nextval, 'Waterloo','Benjimi');
INSERT INTO sc_instructors values (sc_instructor_id_seq.nextval, 'Alex','Wang');
INSERT INTO sc_instructors values (sc_instructor_id_seq.nextval, 'Luke','Lu');
INSERT INTO sc_instructors values (sc_instructor_id_seq.nextval, 'Simong','Kichen');
INSERT INTO sc_instructors values (sc_instructor_id_seq.nextval, 'Bella','Carly');
INSERT INTO sc_instructors values (sc_instructor_id_seq.nextval, 'Katty','Smith');
INSERT INTO sc_instructors values (sc_instructor_id_seq.nextval, 'Jimi','Hee');
INSERT INTO sc_instructors values (sc_instructor_id_seq.nextval, 'Rose','Zhang');
INSERT INTO sc_instructors values (sc_instructor_id_seq.nextval, 'Dynial','Watte');
commit;

INSERT INTO sc_courses values (sc_course_id_seq.nextval, 'C# Programming',3,'N',1);
INSERT INTO sc_courses values (sc_course_id_seq.nextval, 'Java Programming',3,'N',1);
INSERT INTO sc_courses values (sc_course_id_seq.nextval, 'Python Programming',3,'N',3);
INSERT INTO sc_courses values (sc_course_id_seq.nextval, 'Math 185',3,'N',4);
INSERT INTO sc_courses values (sc_course_id_seq.nextval, 'Canada History',3,'N',5);
INSERT INTO sc_courses values (sc_course_id_seq.nextval, 'Irrational',3,'N',2);
INSERT INTO sc_courses values (sc_course_id_seq.nextval, 'Enviroment',3,'N',2);
INSERT INTO sc_courses values (sc_course_id_seq.nextval, 'Construction',3,'N',3);
INSERT INTO sc_courses values (sc_course_id_seq.nextval, 'Web Developer',3,'N',1);
INSERT INTO sc_courses values (sc_course_id_seq.nextval, 'Database Concept',3,'N',1);


INSERT INTO sc_courseinstructors values (1,1);
INSERT INTO sc_courseinstructors values (2,2);
INSERT INTO sc_courseinstructors values (3,3);
INSERT INTO sc_courseinstructors values (4,4);
INSERT INTO sc_courseinstructors values (5,5);
INSERT INTO sc_courseinstructors values (6,6);
INSERT INTO sc_courseinstructors values (7,7);
INSERT INTO sc_courseinstructors values (8,8);
INSERT INTO sc_courseinstructors values (9,9);
INSERT INTO sc_courseinstructors values (10,10);


commit;
--INDEXES =======================================================================================


--TRIGGERS ======================================================================================



--PROCEDURES ====================================================================================



--FUNCTIONS =====================================================================================
