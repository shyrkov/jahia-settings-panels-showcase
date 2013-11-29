<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ page import="java.lang.management.ManagementFactory" %>
<%@ page import="java.lang.management.MemoryMXBean" %>
<%@ page import="java.lang.management.MemoryUsage" %>
<%
MemoryMXBean memoryMXBean = ManagementFactory.getMemoryMXBean();
MemoryUsage usage = memoryMXBean.getHeapMemoryUsage();
pageContext.setAttribute("usageHeap", Math.round((float) usage.getUsed() / (float) usage.getMax() * 100f));
usage = memoryMXBean.getNonHeapMemoryUsage();
pageContext.setAttribute("usageNonHeap", Math.round((float) usage.getUsed() / (float) usage.getMax() * 100f));
%>
<template:addResources type="javascript" resources="https://www.google.com/jsapi"/>
<template:addResources>
    <script type='text/javascript'>
      google.load('visualization', '1', {packages:['gauge']});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Label', 'Value'],
          ['Heap', ${usageHeap}],
          ['Non-heap', ${usageNonHeap}]
        ]);

        var options = {
          width: 600, height: 180,
          redFrom: 90, redTo: 100,
          yellowFrom:75, yellowTo: 90,
          minorTicks: 5
        };

        var chart = new google.visualization.Gauge(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
</template:addResources>
<h1>Showcase server settings panel</h1>
<h2>Memory usage</h2>
<div id='chart_div'></div>
<p style="font-size: 0.8em">visualized using Google Charts</p>
