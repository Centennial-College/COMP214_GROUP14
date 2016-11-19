<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="COMP214_GROUP14._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Small College</h1>
        <div class="container">
            This is a small college management system developed by ASP.NET and Oracle.<br />
 <%--             This project involves six tables
           <dl>
                <dd>- Courses</dd>
                <dd>- CourseInstructor</dd>
                <dd>- Department</dd>
                <dd>- Enrollement</dd>
                <dd>- OfficeAssignment</dd>
                <dd>- Person</dd>
            </dl>--%>
        </div>
    </div>

    <div class="row">
        <div class="col-md-6">
            <h2>Project Guidelines</h2>
            <div class="well">
                <strong>Course Name:</strong> Advance Database Concepts<br />
                <strong>Course Code:</strong> COMP214<br />
                <strong>Term: </strong>Fall 2016<br />
                You will work in groups of maximum 4 people. Tasks will include: 
                <ul>
                    <li>Interface Design 
                    </li>
                    <li>application logic and programming
                    </li>
                    <li>database design and implementation, data creation
                    </li>
                </ul>
                <div class="pull-right"><a href="documents/guide.doc" class="btn btn-primary btn-md">Get Guidelines &raquo;</a></div>
            </div>

        </div>
        <div class="col-md-6">
            <h2>Team Members</h2>
            <div class="well">
                <ul>
                    <li>Luke Lu – Team Leader, .Net Web Developer 
                    </li>
                    <li>Kevin Ma – PL/SQL
                    </li>
                    <li>Kareem Marzouk – PL/SQL
                    </li>
                    <li>Bhavin Master – PL/SQL
                    </li>

                </ul>
                <br />
                <br />
                <br />
                <div class="pull-right"><a href="https://github.com/lukelu6666/COMP214_GROUP14" target="_blank" class="btn btn-primary btn-md">Get Source Code &raquo;</a></div>
            </div>
        </div>

    </div>

</asp:Content>
