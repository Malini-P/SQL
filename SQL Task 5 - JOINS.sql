create database if not exists hospital_db;

use hospital_db;

create table doctors(
doctorId int primary key,
doctorName varchar(50),
specialization varchar(50));

create table patients(
patientId int primary key,
patientName varchar(50),
age int,
city varchar(50));

create table appointments(
appointmentId int primary key,
patientId int,
doctorId int,
appointDate date,
progress varchar(50),
foreign key (patientId) references patients(patientId),
foreign key (doctorId) references doctors(doctorId));

insert into doctors values
(1, 'Dr. Yujin', 'Cardiologist'),
(2, 'Dr. Priya', 'Neurologist'),
(3, 'Dr. John', 'Orthopedic'),
(4, 'Dr. Ramesh', 'Dermatologist'),
(5, 'Dr. Jerin', 'Pediatrician');

insert into patients values
(101, 'Malini', 22, 'Banglore'),
(102, 'Sunitha', 35, 'Madurai'),
(103, 'Raja', 28, 'Trichy'),
(104, 'Ravi', 45, 'Karur'),
(105, 'Megha', 30, 'Salem'),
(106, 'Shyam', 50, 'Tiruvannamalai');

insert into appointments values
(1001, 101, 1, '2026-01-10', 'Completed'),
(1002, 102, 2, '2026-01-12', 'Completed'),
(1003, 103, 1, '2026-01-15', 'Pending'),
(1004, 104, 3, '2026-01-18', 'Completed'),
(1005, 105, 2, '2026-01-20', 'Canceled');

-- New doctors with same specialization

INSERT INTO doctors VALUES
(6, 'Dr. Meena',   'Cardiologist'),
(7, 'Dr. Vijay',   'Neurologist');


-- 1. INNER JOIN - Patients who have appointments with doctors

select 
	  p.patientName,
      d.doctorName
from appointments a
inner join patients p
      on a.patientId = p.patientId
inner join doctors d 
      on a.doctorId = d.doctorId;


-- 2. LEFT JOIN - all patients(with or without appointments)

select 
      p.patientName,
      a.appointDate,
      a.progress
from patients p
left join appointments a 
      on p.patientId = a.patientId;


-- 3. RIGHT JOIN - all doctors(with or without appointments)

select 
       d.doctorName,
       a.appointDate,
	   a.progress
from appointments a
right join doctors d
       on a.doctorId = d.doctorId;
       
-- 4. FULL JOIN

select
      p.patientName,
      d.doctorName,
      a.appointDate
from patients p
left join appointments a 
      on p.patientId = a.patientId
left join doctors d 
      on a.doctorId = d.doctorId
union
select 
     p.patientName,
     d.doctorName,
     a.appointDate
from patients p
right join appointments a 
     on p.patientId = a.patientId
right join doctors d
     on a.doctorId = d.doctorId;
     
-- 5. CROSS JOIN - every patient with every doctor combination

select 
      p.patientName,
      d.doctorName
from patients p 
cross join doctors d;

-- 6. SELF JOIN - New doctors with same specialization

select 
     d1.doctorName as Doctor1,
     d2.doctorName as Doctor2,
     d1.specialization
from doctors d1
join doctors d2 
     on d1.specialization = d2.specialization
     and d1.doctorId < d2.doctorId;
     