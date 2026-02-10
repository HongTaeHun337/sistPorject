-- depth 1
--강의실
CREATE SEQUENCE lecture_SEQ;
DROP SEQUENCE lecture_SEQ;

CREATE TABLE LECTURE(
lectureSeq number,
lectureCapacity number not null ,

 CONSTRAINT check_lecture_rules CHECK (
    (lectureSeq BETWEEN 1 AND 3 AND lectureCapacity = 30) -- 1~3이면 30명 고정
    OR
    (lectureSeq BETWEEN 4 AND 6 AND lectureCapacity = 26) -- 4~6이면 26명 고정
 ),
constraint lecture_pk primary key(lectureSeq)

);


--컴퓨터 상태
DROP SEQUENCE computerStatus_SEQ;
CREATE SEQUENCE computerStatus_SEQ;

create table COMPUTER_STATUS(
computerStatusSeq number,
computerStatusState varchar2(20) unique not null,

constraint computer_status_pk primary key(computerStatusSeq)
);


-- depth 2
--유저
DROP SEQUENCE USERS_SEQ;
CREATE SEQUENCE USERS_SEQ;

CREATE TABLE USERS(
    usersSeq number not null ,
    usersName VARCHAR2(50) not null ,
    usersAddress varchar2(150) not null ,
    usersSSN varchar2(14) unique not null ,
    usersTel varchar2(30) not null ,
    usersId varchar2(20) unique not null ,
    usersPw varchar2(20) not null, --트리거 필요!!!!!!!!!!!!!
    authoritySeq number not null ,

    constraint users_pk primary key(usersSeq),
    constraint users_auth_fk foreign key (authoritySeq) REFERENCES AUTHORITY(authoritySeq)
);

commit;

--컴퓨터
DROP SEQUENCE COMPUTER_SEQ;
CREATE SEQUENCE COMPUTER_SEQ;

CREATE TABLE COMPUTER(
    computerSeq number,
    computerStatusSeq number not null ,
    lectureSeq number not null ,

    constraint computer_pk primary key(computerSeq),
    constraint computer_status_fk foreign key (computerStatusSeq) references COMPUTER_STATUS(computerStatusSeq),
    constraint computer_lecture_fk foreign key (lectureSeq) references LECTURE(lectureSeq)
);

-- depth 3
-- 등록교사
CREATE SEQUENCE courseInstructor_SEQ;
DROP SEQUENCE courseInstructor_SEQ;

CREATE TABLE COURSE_INSTRUCTOR(
    courseInstructorSeq number,
    courseInstructorStartDate Date,
    courseInstructorEndDate Date,
    affiliatedInstructorSeq number not null ,
    registeredCourseSeq number not null ,

    constraint coures_pk primary key (courseInstructorSeq),
    constraint coures_affil_fk foreign key (affiliatedInstructorSeq) REFERENCES AFFILIATED_INSTRUCTOR(affiliatedInstructorSeq),
    constraint coures_regist_fk foreign key (registeredCourseSeq) REFERENCES REGISTERED_COURSE(registeredCourseSeq)
);

-- depth 4
-- 근태
CREATE SEQUENCE attendance_SEQ;
DROP SEQUENCE attendance_SEQ;

CREATE TABLE ATTENDANCE(
    attendanceSeq NUMBER,
    attendanceDate DATE not null ,
    attendanceCheckIn DATE,
    attendanceCheckOut DATE,
    studentSeq NUMBER not null ,
    attendanceTypeSeq NUMBER not null ,

    CONSTRAINT attend_pk primary key (attendanceSeq),
    constraint attend_student_fk foreign key (studentSeq) references STUDENT (studentSeq),
    constraint attend_Type_fk foreign key (attendanceTypeSeq) references ATTENDANCE_TYPE (attendanceTypeSeq)
);

-- 사물함 개인배정
CREATE SEQUENCE personalLocker_SEQ;
DROP SEQUENCE personalLocker_SEQ;

CREATE TABLE PERSONAL_LOCKER(
    personalLockerSeq NUMBER,
    personalLockerAllocationDate DATE,
    personalLockerEndDate DATE,
    studentSeq NUMBER,
    lockerSeq NUMBER not null ,

    constraint personallocker_pk primary key (personalLockerSeq),
    constraint person_student_fk foreign key (studentSeq) references STUDENT(studentSeq),
    constraint person_locker_fk foreign key (lockerSeq) references LOCKER (lockerSeq)
);

-- 컴퓨터 개인배정
CREATE SEQUENCE personalComputer_SEQ;
DROP SEQUENCE personalComputer_SEQ;

CREATE TABLE PERSONAL_COMPUTER(
    personalComputerSeq NUMBER,
    personalComputerAllocationDate DATE,
    personalComputerEndDate DATE,
    studentSeq NUMBER ,
    computerSeq NUMBER not null,


    constraint personalcomputer_pk primary key (personalComputerSeq),
    constraint personalcomputer_com_fk foreign key (computerSeq) REFERENCES COMPUTER(computerSeq),
    constraint personalcomputer_student_fk foreign key (studentSeq) REFERENCES STUDENT(studentSeq)
);

-- depth 5
-- 시험성적
CREATE SEQUENCE testGrade_SEQ;
DROP SEQUENCE testGrade_SEQ;

CREATE TABLE TEST_SCORE(
    testGradeSeq NUMBER,
    testGradeScore NUMBER not null ,
    testGradeParticipated VARCHAR2(20) not null ,
    testSeq NUMBER not null ,
    studentSeq NUMBER not null ,

    constraint testscore_pk primary key (testGradeSeq),
    constraint testscore_test_fk foreign key (testSeq) references TEST(testseq),
    constraint testscore_student_fk foreign key (studentSeq) references STUDENT(studentSeq)
);
