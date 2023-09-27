<%@ page import="geografia.Canton" %>
<g:select name="canton" from="${cantones}" optionKey="id" optionValue="nombre" class="form-control" value="${empresa?.canton?.id}"/>
