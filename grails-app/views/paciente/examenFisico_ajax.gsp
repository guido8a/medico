<div style="width: 3%; float: left; margin-right: 5px">
    <a href="#" class="btn btn-info col-md-12" id="btnEditaExamenFisico"
       title="Editar los datos del examen físico">
        <i class="fas fa-edit"></i>
    </a>

    <g:if test="${paciente?.getNinoNina() == 'Niña'}">
        <g:if test="${edad > 2 && edad < 20}">
            <a href="#" class="btn btn-success col-md-12" id="btnGraficoIMCNinia" title="Gráfico estadístico IMC" style="margin-top: 5px">
                <i class="fas fa-image"></i>
            </a>
        </g:if>
        <g:if test="${edad < 5}">
            <a href="#" class="btn btn-warning col-md-12" id="btnGraficoPCNinia" title="Gráfico estadístico ENCEFÁLICO" style="margin-top: 5px">
                <i class="fas fa-image"></i>
            </a>
            <a href="#" class="btn btn-info col-md-12" id="btnGraficoPesoNinia" title="Gráfico estadístico PESO" style="margin-top: 5px">
                <i class="fas fa-image"></i>
            </a>
            <a href="#" class="btn btn-success col-md-12" id="btnGraficoTallaNinia" title="Gráfico estadístico TALLA" style="margin-top: 5px">
                <i class="fas fa-image"></i>
            </a>
        </g:if>
    </g:if>
    <g:if test="${paciente?.getNinoNina() == 'Niño'}">
        <g:if test="${edad > 2 && edad < 20}">
            <a href="#" class="btn btn-success col-md-12" id="btnGraficoIMCNino" title="Gráfico estadístico IMC" style="margin-top: 5px">
                <i class="fas fa-image"></i>
            </a>
        </g:if>
        <g:if test="${edad < 5}">
            <a href="#" class="btn btn-warning col-md-12" id="btnGraficoPCNino" title="Gráfico estadístico ENCEFÁLICO" style="margin-top: 5px">
                <i class="fas fa-image"></i>
            </a>
            <a href="#" class="btn btn-info col-md-12" id="btnGraficoPesoNino" title="Gráfico estadístico PESO" style="margin-top: 5px">
                <i class="fas fa-image"></i>
            </a>
            <a href="#" class="btn btn-success col-md-12" id="btnGraficoTallaNino" title="Gráfico estadístico TALLA" style="margin-top: 5px">
                <i class="fas fa-image"></i>
            </a>
        </g:if>
    </g:if>
</div>

<div style="width:96%; float: left">
    <table class="table-bordered table-condensed " style="width: 100%">
        <tbody>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-success">Peso:</td>
            <td style="width: 10%; background-color: #b7d6a9">${examen?.peso}</td>
            <td style="width: 10%" class="alert alert-success">Talla:</td>
            <td style="width: 10%; background-color: #b7d6a9">${examen?.talla}</td>
            <td style="width: 10%;" class="alert alert-success">IMC:</td>
            <td style="width: 10%; background-color: #b7d6a9">${examen?.imc}</td>
            <td style="width: 10%;" class="alert alert-success">IC:</td>
            <td style="width: 10%; background-color: #b7d6a9">${examen?.ic}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-success">Temperatura:</td>
            <td style="width: 10%; background-color: #b7d6a9">${examen?.temperatura}</td>
            <td style="width: 10%" class="alert alert-success">SO2:</td>
            <td style="width: 10%; background-color: #b7d6a9">${examen?.so2}</td>
            <td style="width: 10%;" class="alert alert-success">FC:</td>
            <td style="width: 10%; background-color: #b7d6a9">${examen?.fc}</td>
            <td style="width: 10%;" class="alert alert-success">Glucosa:</td>
            <td style="width: 10%; background-color: #b7d6a9">${examen?.glucosa}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-success">Tensión arterial1:</td>
            <td style="width: 10%; background-color: #b7d6a9">${examen?.sistole1} ${examen?.sistole1 ? '/' : ''} ${examen?.diastole1}</td>

            <td style="width: 10%" class="alert alert-success">Tensión arterial2:</td>
            <td style="width: 10%; background-color: #b7d6a9">${examen?.sistole2} ${examen?.sistole2 ? '/' : ''} ${examen?.diastole2}</td>

            <td style="width: 10%;" class="alert alert-success">P. Cefálico:</td>
            <td style="width: 10%; background-color: #b7d6a9">${examen?.perimetroCefalico}</td>
        </tr>

        </tbody>
    </table>
    <table class="table-bordered table-condensed " style="width: 100%">
        <tbody>
        <tr style="font-size: 16px">
            <td style="width: 100%; text-align: center; font-weight: bold" colspan="4" class="alert alert-success">Cabeza</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 11%" class="alert alert-success">Cráneo:</td>
            <td style="width: 40%; background-color: #b7d6a9">${examen?.cabezaCraneo}</td>
            <td style="width: 10%" class="alert alert-success">Cara:</td>
            <td style="width: 40%; background-color: #b7d6a9">${examen?.cabezaCara}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-success">Cuello:</td>
            <td style="width: 40%; background-color: #b7d6a9">${examen?.cuello}</td>
            <td style="width: 10%" class="alert alert-success">Cardiopulmonar:</td>
            <td style="width: 40%; background-color: #b7d6a9">${examen?.cardioPulmonar}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-success">Tórax:</td>
            <td style="width: 40%; background-color: #b7d6a9" colspan="3">${examen?.torax}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-success">Abdomen:</td>
            <td style="width: 40%; background-color: #b7d6a9">${examen?.abdomen}</td>
            <td style="width: 10%" class="alert alert-success">Región Lumbar:</td>
            <td style="width: 40%; background-color: #b7d6a9">${examen?.regionLumbar}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-success">Genitales:</td>
            <td style="width: 40%; background-color: #b7d6a9">${examen?.genitales}</td>
            <td style="width: 10%" class="alert alert-success">Neurológico:</td>
            <td style="width: 40%; background-color: #b7d6a9">${examen?.neurologico}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-success">Extremidades inf.:</td>
            <td style="width: 40%; background-color: #b7d6a9">${examen?.extremidadesInferiores}</td>
            <td style="width: 10%" class="alert alert-success">Extremidades sup.:</td>
            <td style="width: 40%; background-color: #b7d6a9">${examen?.extremidadesSuperiores}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-success">Piel y Faneras:</td>
            <td style="width: 10%; background-color: #b7d6a9" colspan="7">${examen?.pielFaneras}</td>
        </tr>
        </tbody>
    </table>
</div>

<script type="text/javascript">
    $("#btnEditaExamenFisico").click(function () {
        var cita = '${cita?.id}';
        if(cita){
            createEditRowExamenFisico();
        }else{
            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' +
                '<strong style="font-size: 14px">' + "No ha seleccionado una cita" + '</strong>');
        }
    });

    $("#btnGraficoIMCNinia").click(function() {
        tipoGrafico("imcNina")
    });

    $("#btnGraficoIMCNino").click(function() {
        tipoGrafico("imcNino")
    });

    $("#btnGraficoPCNinia").click(function () {
        tipoGrafico("pcNina")
    });

    $("#btnGraficoPCNino").click(function () {
        tipoGrafico("pcNino")
    });

    $("#btnGraficoPesoNinia").click(function () {
        tipoGrafico("pesoNina")
    });

    $("#btnGraficoPesoNino").click(function () {
        tipoGrafico("pesoNino")
    });

    $("#btnGraficoTallaNinia").click(function () {
        tipoGrafico("tallaNina")
    });

    $("#btnGraficoTallaNino").click(function () {
        tipoGrafico("tallaNino")
    });

    function tipoGrafico(tipo) {
        var cita = '${cita?.id}';
        var examen = '${examen?.id}';
        if(cita){
            if(examen){
                cargarGrafico(tipo);
            }else{
                bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + "Ingrese los datos del examen físico" + '</strong>');
            }
        }else{
            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' +
                '<strong style="font-size: 14px">' + "No ha seleccionado una cita" + '</strong>');
        }
    }

</script>