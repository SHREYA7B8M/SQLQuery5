drop database Assesment05Db

create database Assesment05Db

use Assesment05Db

create schema bank

create table bank.Customer (
    CId int primary key identity(1000, 1),
    CName nvarchar(50) not null,
    CEmail nvarchar(50) not null unique,
    Contact nvarchar(20) not null unique,
    CPwd as substring(CName, len(CName) - 1, 2) + convert(nvarchar(10), CId) + substring(Contact, 1, 2) persisted
)

create table bank.MailInfo (
    MailID int primary key identity(1000,1),
    MailTo nvarchar(50) not null,
    MailDate date not null,
    MailMessage nvarchar(200) not null 
)
    
create trigger bank.trgMailToCust
on bank.Customer
after insert
as
begin
    insert into bank.MailInfo (MailTo, MailDate, MailMessage)
    select i.CEmail, GETDATE(), 'Your net banking password is ' + i.CPwd + '. It is valid up to 2 days only. Update it.'
    from inserted i
end

insert into bank.Customer values ('Ethan Hunt','ethan@imf.com','9876543210')
insert into bank.Customer values ('Ilsa Faust','ilsa@imf.com','9753124680')
insert into bank.Customer values ('Benji Dunn','benji@imf.com','8769012354')
insert into bank.Customer values ('Luther Stickley','luther@imf.com','7890123465')
insert into bank.Customer values ('Grace Williams','grace@imf.com','9988776655')

select * from bank.Customer

select * from bank.MailInfo
