<%--

    Copyright © 2014 Instituto Superior Técnico

    This file is part of Fenix Parking.

    Fenix Parking is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Fenix Parking is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public License
    along with Fenix Parking.  If not, see <http://www.gnu.org/licenses/>.

--%>
<%@ page language="java" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="http://fenix-ashes.ist.utl.pt/fenix-renderers" prefix="fr" %>
<%@ taglib uri="http://jakarta.apache.org/taglibs/string-1.0.1" prefix="str" %>
<html:xhtml/>

<h2><bean:message key="link.create.external.person"/></h2>

<p>
	<span class="error0"><!-- Error messages go here --><html:errors/></span>
</p>

<fr:form action="/externalPerson.do">
	<html:hidden bundle="HTMLALT_RESOURCES" altKey="hidden.method" property="method" value="search"/>

	<p class="mtop15"><strong><bean:message key="label.search.for.external.person" bundle="MANAGER_RESOURCES" /></strong></p>
	<fr:edit id="anyPersonSearchBean" name="anyPersonSearchBean" schema="net.sourceforge.fenixedu.domain.Person.AnyPersonSearchBean" >
		<fr:layout name="tabular" >
			<fr:property name="classes" value="tstyle5 thlight thright mtop05"/>
	        <fr:property name="columnClasses" value=",,tderror1 tdclear"/>
		</fr:layout>
	</fr:edit>
	<html:submit><bean:message key="button.submit" bundle="MANAGER_RESOURCES" /></html:submit>
</fr:form>



<logic:equal name="anyPersonSearchBean" property="hasBeenSubmitted" value="true">

	<bean:define id="people" name="anyPersonSearchBean" property="search"/>
	<logic:notEmpty name="people">
		<table class="tstyle1 thlight mtop2">
			<tr>
				<th scope="col"><bean:message key="label.name" bundle="MANAGER_RESOURCES"/></th>
				<th scope="col"><bean:message key="label.identification" bundle="MANAGER_RESOURCES"/></th>
				<th scope="col"><bean:message key="label.person.unit.info" bundle="MANAGER_RESOURCES"/></th>
				<th scope="col"><bean:message key="label.has.parking.party"/></th>
				<th scope="col" class="width10em"></th>
			</tr>
			<logic:iterate id="person" name="people">
				<bean:define id="organizationalUnitsPresentation" name="person" property="organizationalUnitsPresentation"/>
				<bean:size id="numberUnitsTemp" name="person" property="organizationalUnitsPresentation"/>
				<bean:define id="numberUnits"><bean:write name="numberUnitsTemp"/></bean:define>
				<logic:empty name="organizationalUnitsPresentation">
					<bean:define id="numberUnits" value="1"/>
				</logic:empty>
				<tr>
					<td rowspan="<%= numberUnits %>"><bean:write name="person" property="name"/></td>
					<bean:define id="docIDTitle" type="java.lang.String"><logic:present name="person" property="idDocumentType"><bean:message name="person" property="idDocumentType.name" bundle="ENUMERATION_RESOURCES"/></logic:present></bean:define>
					<td class="acenter width10em" rowspan="<%= numberUnits %>" title="<%= docIDTitle %>"><bean:write name="person" property="documentIdNumber"/></td>
					<logic:empty name="person" property="organizationalUnitsPresentation">
						<td>-</td>
					</logic:empty>
					<logic:iterate id="unitName" name="organizationalUnitsPresentation" length="1">
						<td>
							<bean:write name="unitName"/>
						</td>
					</logic:iterate>
					<logic:present name="person" property="parkingParty">
						<td class="acenter width5em" rowspan="<%= numberUnits %>">
							<bean:message key="label.yes"/>
						</td>
						<td class="acenter" rowspan="<%= numberUnits %>">-</td>
					</logic:present>
					<logic:notPresent name="person" property="parkingParty">
						<td class="acenter width5em" rowspan="<%= numberUnits %>">
							<bean:message key="label.no"/>
						</td>
						<td rowspan="<%= numberUnits %>" class="acenter">
							<bean:define id="url" type="java.lang.String">/externalPerson.do?method=createParkingParty&amp;personID=<bean:write name="person" property="externalId"/></bean:define>
							<html:link page="<%= url %>"><bean:message key="link.create.external.person" /></html:link>
						</td>
					</logic:notPresent>
				</tr>
				<logic:iterate id="unitName" name="organizationalUnitsPresentation" offset="1">
					<tr>
						<td>
							<bean:write name="unitName"/>
						</td>
					</tr>
				</logic:iterate>
			</logic:iterate>
		</table>

	<bean:define id="url" type="java.lang.String">/externalPerson.do?method=prepareCreate&amp;name=<bean:write name="anyPersonSearchBean" property="name"/>&amp;idDocumentType=<bean:write name="anyPersonSearchBean" property="idDocumentType"/>&amp;documentIdNumber=<bean:write name="anyPersonSearchBean" property="documentIdNumber"/></bean:define>
	<p>
		<bean:message key="label.create.external.person.afterSearch" bundle="MANAGER_RESOURCES"/>: 
		<html:link action="<%= url %>">
			<bean:message key="link.create.person.user"/>
		</html:link>
	</p>
	</logic:notEmpty>	
</logic:equal>

<logic:empty name="people">
<p><em><bean:message key="label.userNotFound"/></em></p>
<bean:define id="url" type="java.lang.String">/externalPerson.do?method=prepareCreate&amp;name=<bean:write name="anyPersonSearchBean" property="name"/>&amp;idDocumentType=<bean:write name="anyPersonSearchBean" property="idDocumentType"/>&amp;documentIdNumber=<bean:write name="anyPersonSearchBean" property="documentIdNumber"/></bean:define>
	<p>
		<bean:message key="label.create.external.person.afterSearch" bundle="MANAGER_RESOURCES"/>: 
		<html:link action="<%= url %>">
			<bean:message key="link.create.person.user"/>
		</html:link>
	</p>
</logic:empty>