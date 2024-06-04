
<style type="text/css">

.lleno{
    background-color: #e25529;
    text-align: center;
}

.libre{
    background-color: #8bb474;
}

</style>



<div role="main" style="margin-top: 10px;">
    <table class="table table-bordered table-striped table-condensed table-hover">
        <thead>
        <tr>
            <th style="width: 14%">Hora</th>
            <th style="width: 14%">Lunes</th>
            <th style="width: 14%">Martes</th>
            <th style="width: 14%">Miércoles</th>
            <th style="width: 14%">Jueves</th>
            <th style="width: 14%">Viernes</th>
            <th style="width: 14%">Sábado</th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 99.7%;height: 600px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-striped table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:if test="${datos}">
            <tr >
                <td style="width: 14%">${"7:30 - 8:00"}</td>
                <td style="width: 14%" class="lleno">${"Agendado"}</td>
                <td style="width: 14%" class="libre">${""}</td>
                <td style="width: 14%" class="libre">${""}</td>
                <td style="width: 14%" class="libre">${""}</td>
                <td style="width: 14%" class="libre">${""}</td>
                <td style="width: 14%" class="libre">${""}</td>
            </tr>
            <tr >
                <td style="width: 14%">${"8:00 - 8:30"}</td>
                <td style="width: 14%" class="libre">${""}</td>
                <td style="width: 14%" class="libre">${""}</td>
                <td style="width: 14%" class="lleno">${"Agendado"}</td>
                <td style="width: 14%" class="libre">${""}</td>
                <td style="width: 14%" class="libre">${""}</td>
                <td style="width: 14%" class="libre">${""}</td>
            </tr>
            <tr >
                <td style="width: 14%">${"8:30 - 9:00"}</td>
                <td style="width: 14%" class="libre">${""}</td>
                <td style="width: 14%" class="libre">${""}</td>
                <td style="width: 14%" class="libre">${""}</td>
                <td style="width: 14%" class="libre">${""}</td>
                <td style="width: 14%" class="libre">${""}</td>
                <td style="width: 14%" class="lleno">${"Agendado"}</td>
            </tr>
        </g:if>
        <g:else>
            <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> Seleccione los datos para agendar</div>
        </g:else>
        </tbody>
    </table>
</div>

<script type="text/javascript">



</script>