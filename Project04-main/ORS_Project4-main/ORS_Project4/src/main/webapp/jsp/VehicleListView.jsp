<%@page import="com.rays.pro4.Util.HTMLUtility"%>
<%@page import="com.rays.pro4.Util.DataUtility"%>
<%@page import="com.rays.pro4.Util.ServletUtility"%>
<%@page import="com.rays.pro4.Bean.VehicleBean"%>
<%@ page import="com.rays.pro4.controller.VehicleListCtl" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
<link rel="icon" type="image/png"
    href="<%= ORSView.APP_CONTEXT %>/img/logo.png" sizes="16*16" />

<title>Vehicle List</title>
<link rel="stylesheet"
    href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">


<script src="<%= ORSView.APP_CONTEXT %>/js/jquery.min.js"></script>
<script src="<%= ORSView.APP_CONTEXT %>/js/Checkbox11.js"></script>

<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
    $(function() {
        $("#udate").datepicker({
            changeMonth : true,
            changeYear : true,
            yearRange : '1980:2002',
        });
    });
</script>

</head>
<body>
    <%@ include file="Header.jsp" %>

    <form action="<%= ORSView.VEHICLE_LIST_CTL %>" method="post">

        <center>
            <div align="center">
                <h1>Vehicle List</h1>
                <h3>
                    <font color="red"><%= ServletUtility.getErrorMessage(request) %></font>
                    <font color="green"><%= ServletUtility.getSuccessMessage(request) %></font>
                </h3>
            </div>

            <%
                int next = DataUtility.getInt(request.getAttribute("nextlist").toString());
                List<VehicleBean> proList = (List<VehicleBean>) request.getAttribute("proList");
            %>

            <%
                int pageNo = ServletUtility.getPageNo(request);
                int pageSize = ServletUtility.getPageSize(request);
                int index = ((pageNo - 1) * pageSize) + 1;

                List<VehicleBean> list = (List<VehicleBean>) ServletUtility.getList(request);
                Iterator<VehicleBean> it = list.iterator();

                if (list.size() != 0) {
            %>
            <table width="100%" align="center">
                <tr>
                    <th></th>
                    <td align="center"><label>Number</label>
                        <input type="text" name="number"
                            placeholder="Enter Number"
                            value="<%= ServletUtility.getParameter("number", request) %>">
                        &emsp; <label>PurchaseDate</font> :
					</label> <%=HTMLUtility.getList("proList", String.valueOf(bean.getPurchaseDate()), proList)%>
						&nbsp; <input type="submit" name="operation"
						value="<%=VehicleListCtl.OP_SEARCH%>"> &nbsp; <input
						type="submit" name="operation"
						value="<%=VehicleListCtl.OP_RESET%>"></td>
                </tr>
            </table>
            <br>

            <table border="1" width="100%" align="center" cellpadding="6px"
                cellspacing=".2">
                <tr style="background: skyblue">
                    <th><input type="checkbox" id="select_all" name="select">Select
                        All</th>
                    <th>S.No.</th>
                    <th>Number</th>
                    <th>Purchase Date</th>
                    <th>Insurance Amount</th>
                    <th>Colour</th>
                    <th>Edit</th>
                </tr>

                <%
                    while (it.hasNext()) {
                        VehicleBean bean = it.next();
                %>
                <tr align="center">
                    <td><input type="checkbox" class="checkbox" name="ids"
                        value="<%= bean.getId() %>"></td>
                    <td><%= index++ %></td>
                    <td><%= bean.getNumber() %></td>
                    <td><%= bean.getPurchaseDate() %></td>
                    <td><%= bean.getInsuranceAmount() %></td>
                    <td><%= bean.getColour() %></td>
                    <td><a href="ProductCtl?id=<%= bean.getId() %>">Edit</a></td>
                </tr>
                <%
                    }
                %>
            </table>

            <table width="100%">
                <tr>
                    <th></th>
                    <%
                        if (pageNo == 1) {
                    %>
                    <td><input type="submit" name="operation" disabled="disabled"
                        value="<%= VehicleListCtl.OP_PREVIOUS %>"></td>
                    <%
                        } else {
                    %>
                    <td><input type="submit" name="operation"
                        value="<%= VehicleListCtl.OP_PREVIOUS %>"></td>
                    <%
                        }
                    %>
                    <td><input type="submit" name="operation"
                        value="<%= VehicleListCtl.OP_DELETE %>"></td>
                    <td><input type="submit" name="operation"
                        value="<%= VehicleListCtl.OP_NEW %>"></td>
                    <td align="right"><input type="submit" name="operation"
                        value="<%= VehicleListCtl.OP_NEXT %>"
                        <%=(list.size() < pageSize || next == 0) ? "disabled" : ""%>></td>
                </tr>
            </table>
            <%
                }
                if (list.size() == 0) {
            %>
            <td align="center"><input type="submit" name="operation"
                value="<%= VehicleListCtl.OP_BACK %>"></td>
            <%
                }
            %>
            <input type="hidden" name="pageNo" value="<%= pageNo %>"> 
            <input type="hidden" name="pageSize" value="<%= pageSize %>">
        </center>
    </form>
    <%@ include file="Footer.jsp" %>
</body>
</html>
