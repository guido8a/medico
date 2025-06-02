
<style type="text/css">
div.mes {
    float: left;
    margin: 0 0 10px 10px;
    height: 175px;
}

table.mes {
    border-collapse: separate;
    border-radius: 8px;
    border-style: solid;
    border-width: 1px;
}
table tr th {  /*los th dentro de tr dentro de table */
    text-align: center;
}
td, th {
    padding: 0.1rem;
}
.dia {
    width: 29px;
    text-align: center;
    cursor: pointer;
}

.vacio {
    background-color: #dddddd;
}

.vacacion {
    background-color: #a2c1cb;
}

h1 {
    text-align: center;
}

.demo {
    width: 20px;
    height: 20px;
    text-align: center;
    display: inline-block;
}

.nombreMes {
    font-size: 16px;
}
.actual {
    background-color: #a2c1cb !important;
}
</style>

<g:set var="mesAct" value="${null}"/>
<g:each in="${dias}" var="dia" status="i">
    <g:set var="mes" value="${meses[dia.fecha.format('MM').toInteger()]}"/>
    <g:set var="mesNum" value="${dia.fecha.format('MM').toInteger()}"/>
    <g:if test="${mes != mesAct}">
        <g:if test="${mesAct}">
            </table>
            </div>
        </g:if>
        <g:set var="mesAct" value="${mes}"/>
        <g:set var="num" value="${1}"/>
        <div class="mes">
        <table class="mes">
        <thead>
        <tr>
            <th class="nombreMes ${hoy.format('MM').toInteger() == mesNum ? 'actual' : ''}"
            colspan="7" style="text-align: center; background-color: #d0d0d0; user-select: none">
            ${mesAct}</th>
        </tr>
        <tr>
            <th style="user-select: none">Lun</th>
            <th>Mar</th>
            <th>Mié</th>
            <th>Jue</th>
            <th>Vie</th>
            <th>Sáb</th>
            <th>Dom</th>
        </tr>
        </thead>
    </g:if>
    <g:if test="${num % 7 == 1}">
        <tr>
    </g:if>
    <g:if test="${dia.fecha.format("dd").toInteger() == 1}">
        <g:if test="${dia.dia.toInteger() != 1}">%{--No empieza en lunes: hay q dibujar celdas vacias en los dias necesarios--}%
            <g:each in="${1..(dia.dia.toInteger() - 1 + (dia.dia.toInteger() > 0 ? 0 : 7))}" var="extra">
                <td class="vacio"></td>
                <g:set var="num" value="${num + 1}"/>
            </g:each>
        </g:if>
    </g:if>

    <td class="dia ${dia.cita != '' ? 'vacacion' : ''}" data-fecha="${dia.fecha.format('dd-MM-yyyy')}"
        data-id="${dia.cita != '' ? dia.idH : ''}" title="${dia?.titl}">
        ${dia.fecha.format("dd")}
    </td>

    <g:set var="num" value="${num + 1}"/>

    <g:if test="${i == dias.size() - 1 || (i < dias.size() - 1) && (meses[dias[i + 1].fecha.format('MM').toInteger()] != mesAct)}">
        <g:if test="${dia.dia.toInteger() != 0}">
            <g:each in="${1..7 - (num % 7 > 0 ? num % 7 : 7) + 1}" var="extra">
                <td class="vacio"></td>
            </g:each>
        </g:if>
    </g:if>
</g:each>
</table>

<script type="application/javascript">

    $(".dia").click(function () {
        var id = $(this).data("id");
        if(id !== ''){
            cargarComboCita(id);
            cerrarCalendario();
        }

    });
</script>
