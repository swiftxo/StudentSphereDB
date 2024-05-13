-- SHOW OFF TABLES
SHOW TABLES;
select * from students;
select * from contactinfo;
select * from emergencycontact;
select * from major;
select * from minor;
select * from courseinfo;
select * from coursegrade;
select * from studentgrades;
select * from academicinfo;

-- DEMO INSERTION
INSERT INTO STUDENTS VALUES (100007,"Prithvi","Paturi","Narayana","Male",1,"2004-10-24",13,23);
INSERT INTO CONTACTINFO VALUES (100007,"patu3136@mylaurier.ca","prithvi.paturi@gmail.com",6476152404,"47 Tarmack Drive","L4E0E8",'Richmond Hill','Ontario',"Canada");
INSERT INTO EmergencyContact (student_id,contact_name,contact_phone) VALUES (100007,"Zohib Ahmadi","6477132997");
select * from students where student_id = 100007;
select * from contactinfo where student_id = 100007;
select * from emergencycontact where student_id = 100007;

INSERT INTO coursegrade (student_id,course_id,component,score,weight) VALUES (100007,"CP363","Midterm II",76,30),(100007,"CP363","Project Report",80,15),(100007,"CP363","Presentation",100,15),(100007,"CP363","Final Exam",95,40);
select * from coursegrade where student_id = 100007;


INSERT INTO AcademicInfo (student_id,current_year,credits_completed,credits_required,overall_grade) VALUES (100007,1,0,20,0);

INSERT INTO COURSEINFO VALUES ("PS204","Psychology Of Prithvi Paturi","Year Long",1.00,"Shaun Gao");
select * from COURSEINFO where course_id = "PS204"


 -- UPDATE INFO
INSERT INTO studentgrades (student_id, course_id, course_grade)
SELECT
    cg.student_id,
    cg.course_id,
    ROUND(SUM(cg.score * cg.weight / 100), 2) AS overall_grade
FROM
    coursegrade cg
GROUP BY
    cg.student_id,
    cg.course_id
ON DUPLICATE KEY UPDATE
    course_grade = VALUES(course_grade);


UPDATE academicinfo ai
SET ai.overall_grade = (
    SELECT AVG(sg.course_grade)
    FROM studentgrades sg
    WHERE sg.student_id = ai.student_id
    GROUP BY sg.student_id
);



-- SHOW STUDENT_ID, FULL NAME, HIS MAJOR NAME, MINOR NAME AND OVERALL GPA

SELECT
    s.student_id,
    CONCAT(s.first_name, ' ', s.last_name) AS full_name,
    mj.major_name,
    mn.minor_name,
    ai.overall_grade
FROM
    students s
LEFT JOIN
    major mj ON s.major_id = mj.major_id
LEFT JOIN
    minor mn ON s.minor_id = mn.minor_id
LEFT JOIN
    academicinfo ai ON s.student_id = ai.student_id;
