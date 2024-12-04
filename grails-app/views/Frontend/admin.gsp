<%--
  Created by IntelliJ IDEA.
  User: shivamkhandelwal
  Date: 12/04/24
  Time: 10:36 AM
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>admin page</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="${assetPath(src: 'admin.css')}" type="text/css">
    <link rel="stylesheet" href="${assetPath(src: 'Login.css')}" type="text/css">
    <link rel="stylesheet" href="${assetPath(src: 'dash.css')}" type="text/css">
</head>
<style>
table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}

.heading{
    background-color: #888888;
    display: flex;
    justify-content: space-between;
    align-items: center;
}
</style>
<body>
<g:render template="/templates/navbar"  model="[subscription_Topic:subscription_Topic, curr_user: curr_user]"/>

<div class="border" >
    <div class="heading">
%{--        <div class="leftU">--}%
%{--            <h5>Users</h5>--}%
%{--        </div>--}%
%{--        <div class="rightU">--}%
%{--            <div class="usertype">--}%
%{--                <select>--}%
%{--                    <option value="" disabled selected>Serious</option>--}%
%{--                    <option value="option1">Option 1</option>--}%
%{--                    <option value="option2">Option 2</option>--}%
%{--                    <option value="option3">Option 3</option>--}%
%{--                </select>--}%
%{--            </div>--}%
%{--            <div class="search-container sc">--}%
%{--                <span class="search-icon">&#128269;</span>--}%
%{--                <input type="text" class="search-input" placeholder="Search...">--}%
%{--                <span class="close-icon">&#10005;</span>--}%
%{--            </div>--}%
%{--            <div class="btn">--}%
%{--                <button class="chng">Search</button>--}%
%{--            </div>--}%
%{--        </div>--}%
        <h4 style="margin-right: 10px"> List of users </h4>
    </div>
    <div class="table1">
        <table>
            <tr>
                <th>Id</th>
                <th>Username</th>
                <th>Email</th>
                <th>firstname</th>
                <th>Lastname</th>
                <th>Active</th>
                <th>Manage</th>
            </tr>
            <g:if test="${users.size()}">
                <g:each in="${users}" var="curr_user">
                    <g:if test="${curr_user.admin ==false}">


            <tr>
                <td>${curr_user.id}</td>
                <td>${curr_user.username}</td>
                <td>${curr_user.email}</td>
                <td>${curr_user.firstName}</td>
                <td>${curr_user.lastName}</td>
                <td>
                    <g:if test="${curr_user.active}">
                          Yes
                    </g:if>
                    <g:else>
                        No
                    </g:else>
                </td>
                <td>
                    <g:if test="${curr_user.active}">
                        <g:form controller="Admin" action="deactivate">
                            <g:hiddenField name="userId" value="${curr_user.id}" />
                            <button type="submit" style="border: none; background: none; outline: none; cursor: pointer;color: blue;">Deactivate</button>
                        </g:form>

                    </g:if>
                    <g:else>
                        <g:form controller="Admin" action="activate">
                            <g:hiddenField name="userId" value="${curr_user.id}" />
                            <button type="submit" style="border: none; background: none; outline: none; cursor: pointer;color: blue;">Activate</button>
                        </g:form>
                    </g:else>
                </td>
            </tr>
                    </g:if>
                </g:each>
            </g:if>

        </table>
    </div>
</div>
</body>
</html>