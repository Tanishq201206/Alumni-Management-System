<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="ISO-8859-1"%>

<%@taglib uri="http://www.springframework.org/tags" prefix="s"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="crt"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@page isELIgnored="false"%>

<c:url var="addUrl" value="/ctl/employee" />

<c:url var="addSearch" value="/ctl/employee/search" />

<c:url var="editUrl" value="/ctl/employee?id=" />


<br>

<sf:form method="post"
	action="${pageContext.request.contextPath}/ctl/employee/search"
	modelAttribute="form">
	<div class="card">
		<h5 class="card-header"
			style="background-color: #00061df7; color: white;">Employee List</h5>
		<div class="card-body">
			<div class="row g-3">

				<s:bind path="firstName">
					<div class="col">
						<sf:input path="${status.expression}"
							class="form-control form-control-sm"
							placeholder="Search By First Name" />
					</div>
				</s:bind>

				<s:bind path="emailId">
					<div class="col">
						<sf:input path="${status.expression}"
							class="form-control form-control-sm"
							placeholder="Search By Email Id" />
					</div>
				</s:bind>


				<div class="col">
					<input type="submit" class="btn btn-sm btn-outline-primary"
						name="operation" value="Search"></input> or <input type="submit"
						class="btn btn-sm btn-outline-secondary" name="operation"
						value="Reset">
				</div>
			</div>
			<b><%@ include file="businessMessage.jsp"%></b>
			<br>
			<sf:input type="hidden" path="pageNo" />
			<sf:input type="hidden" path="pageSize" />

			<sf:input type="hidden" path="listsize" />
			<sf:input type="hidden" path="total" />
			<sf:input type="hidden" path="pagenosize" />

			<table class="table table-bordered border-primary">
				<thead>
					<tr>
						<c:if test="${sessionScope.user.role.id == 1}">
							<th scope="col"><input type="checkbox" id="selectall">Select
								All</th>
						</c:if>
						<th scope="col">#</th>
						<th scope="col">Name</th>
						<th scope="col">Email Id</th>
						<th scope="col">Mobile No</th>
						<th scope="col">DOB</th>
						<th scope="col">Qualification</th>
						<th scope="col">Experience</th>
						<th scope="col">Profile</th>
						<th scope="col">Joining Date</th>
						<th scope="col">Address</th>
						<c:if test="${sessionScope.user.role.id == 1}">
							<th scope="col">Action</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="em" varStatus="employee">
						<tr>
							<c:if test="${sessionScope.user.role.id == 1}">
								<td><input type="checkbox" class="case" name="ids"
									value="${em.id}"></td>
							</c:if>
							<td scope="row">${employee.index+1}</td>
							<td scope="row">${em.firstName} ${em.lastName}</td>
							<td scope="row">${em.emailId}</td>
							<td scope="row">${em.mobielNo}</td>
							<td scope="row">${em.dob}</td>
							<td scope="row">${em.qualification}</td>
							<td scope="row">${em.exprience}</td>
							<td scope="row">${em.companyProfile}</td>
							<td scope="row">${em.joiningDate}</td>
							<td scope="row">${em.address}</td>
							<c:if test="${sessionScope.user.role.id == 1}">
								
								<td>
									<a href="${editUrl} ${em.id}" ><i class="fas fa-edit"></i></a>
								
										
										</td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>

			<div class="clearfix">
				<c:if test="${sessionScope.user.role.id == 1}">
					<input type="submit" name="operation"
						class="btn btn-sm btn-danger float-start"
						<c:if test="${listsize == 0}">disabled="disabled"</c:if>
						value="Delete">
				</c:if>


				<nav aria-label="Page navigation example float-end">
					<ul class="pagination justify-content-end" style="font-size: 13px">
						<li class="page-item"><input type="submit" name="operation"
							class="page-link"
							<c:if test="${form.pageNo == 1}">disabled="disabled"</c:if>
							value="Previous"></li>
						<c:forEach var="i" begin="1" end="${(listsize/10)+1}">
							<c:if test="${i== pageNo}">
								<li class="page-item active"><a class="page-link activate"
									href="${addSearch}?pageNo=${i}">${i}</a></li>
							</c:if>
							<c:if test="${i != pageNo}">
								<li class="page-item"><a class="page-link"
									href="${addSearch}?pageNo=${i}">${i}</a></li>
							</c:if>
						</c:forEach>
						<li class="page-item"><input type="submit" name="operation"
							class="page-link"
							<c:if test="${total == pagenosize  || listsize < pageSize   }">disabled="disabled"</c:if>
							value="Next"></li>
					</ul>
				</nav>
			</div>


		</div>

	</div>
</sf:form>
