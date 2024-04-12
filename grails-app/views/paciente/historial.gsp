
<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Historial del paciente: ${paciente?.apellido + " " + paciente?.nombre}
    </title>
</head>
<body>

<div class="row" style="margin-bottom: 10px">
    <div class="btn-group col-md-6" >
        <a href="${createLink(controller: 'paciente', action: 'list')}" class="btn btn-info" title="Retornar a búsqueda de pacientes">
            <i class="fas fa-arrow-left"></i> Lista de pacientes
        </a>
    </div>
</div>

<div class="btn-group row" style="margin-top: 20px; text-align: center">
    <span style="font-size: 20px; font-weight: bold">Historial del paciente: ${paciente?.apellido + " " + paciente?.nombre}</span>
</div>

<div class="row">
    <div class="col-md-4">
        <span class="badge badge-secondary" style="font-size: 16px">Datos del paciente</span>
    </div>
</div>

<div class="" style="width: 99.7%; overflow-y: auto;float: right; margin-top: 10px; margin-bottom: 20px">
    <table class="table-bordered table-condensed " style="width: 100%">
        <tbody>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-info">Apellidos:</td>
            <td style="width: 20%; background-color: #c1cfe7">${paciente?.apellido}</td>
            <td style="width: 10%" class="alert alert-info">Nombres:</td>
            <td style="width: 20%; background-color: #c1cfe7">${paciente?.nombre}</td>
            <td style="width: 10%;" class="alert alert-info">Cédula:</td>
            <td style="width: 20%; background-color: #c1cfe7">${paciente?.cedula}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-info">Edad:</td>
            <td style="width: 20%; background-color: #c1cfe7">${""}</td>
            <td style="width: 15%" class="alert alert-info">Fecha nacimiento:</td>
            <td style="width: 20%;background-color: #c1cfe7">${paciente?.fechaNacimiento?.format("dd-MM-yyyy")}</td>
            <td style="width: 15%;" class="alert alert-info">Lugar nacimiento:</td>
            <td style="width: 20%;background-color: #c1cfe7">${""}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-info">Dirección:</td>
            <td style="width: 20%; background-color: #c1cfe7">${paciente?.direccion}</td>
            <td style="width: 15%" class="alert alert-info">Teléfono:</td>
            <td style="width: 20%;background-color: #c1cfe7">${paciente?.telefono}</td>
            <td style="width: 15%;" class="alert alert-info">Email:</td>
            <td style="width: 20%;background-color: #c1cfe7">${paciente?.mail}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-info">Estado Civil:</td>
            <td style="width: 20%; background-color: #c1cfe7">${paciente?.estadoCivil?.descripcion}</td>
            <td style="width: 15%" class="alert alert-info">Sexo:</td>
            <td style="width: 20%;background-color: #c1cfe7">${paciente?.sexo == 'M' ? 'MASCULINO' : 'FEMENINO'}</td>
            <td style="width: 15%;" class="alert alert-info">G. Sanguineo:</td>
            <td style="width: 20%;background-color: #c1cfe7">${paciente?.grupoSanguineo?.descripcion}</td>
        </tr>
        </tbody>
    </table>
</div>

<div class="row" style="margin-top: 20px">
    <div class="col-md-4">
        <span class="badge badge-secondary" style="font-size: 16px">Antecedentes</span>
    </div>
</div>

<div class="" style="width: 99.7%;overflow-y: auto;float: right; margin-top: 10px; margin-bottom: 20px">
    <table class="table-bordered table-condensed " style="width: 100%">
        <tbody>
        <tr style="font-size: 16px">
            <td style="width: 30%; font-weight: bolder" class="alert alert-success">Antecedentes patológicos personales:</td>
            <td style="width: 70%; background-color: #b7d6a9">${paciente?.antecedentes}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 30%;font-weight: bolder" class="alert alert-success">Antecedentes patológicos ocupacionales:</td>
            <td style="width: 70%; background-color: #b7d6a9">${paciente?.antecedentesOcupacionales}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 30%;font-weight: bolder" class="alert alert-success">Antecedentes patológicos familiares:</td>
            <td style="width: 70%; background-color: #b7d6a9">${paciente?.antecedentesPatologicosFam}</td>
        </tr>
        <g:if test="${paciente?.sexo == 'F'}">
            <tr style="font-size: 16px">
                <td style="width: 30%;font-weight: bolder" class="alert alert-success">Antecedentes patológicos gineco obstétricos:</td>
                <td style="width: 70%; background-color: #b7d6a9">${paciente?.antecedentesGinecobstreticos}</td>
            </tr>
        </g:if>
        <tr style="font-size: 16px">
            <td style="width: 30%;font-weight: bolder" class="alert alert-success">Hábitos:</td>
            <td style="width: 70%; background-color: #b7d6a9">${paciente?.habitos}</td>
        </tr>
        </tbody>
    </table>
</div>

<div class="row" style="margin-top: 20px">
    <div class="col-md-4">
        <span class="badge badge-secondary" style="font-size: 16px">Última Cita</span>
    </div>
</div>

<div class="" style="width: 99.7%; overflow-y: auto;float: right; margin-top: 10px; margin-bottom: 20px">
    <table class="table-bordered table-condensed " style="width: 100%">
        <tbody>
        <tr style="font-size: 16px">
            <td style="width: 20%; font-weight: bolder" class="alert alert-warning">Motivo de la consulta:</td>
            <td style="width: 80%; background-color: #ccb35d">${cita?.motivo}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 20%;font-weight: bolder" class="alert alert-warning">Enfermedad actual:</td>
            <td style="width: 80%; background-color:#ccb35d">${cita?.actual}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 20%;font-weight: bolder" class="alert alert-warning">Diagnóstico:</td>
            <td style="width: 80%; background-color:#ccb35d">
                <g:if test="${diagnosticos.size() > 0}">
                    <table class="table table-bordered table-striped table-condensed table-hover">
                        <thead>
                        <tr style="width: 100%">
                            <th style="width: 10%">Código</th>
                            <th style="width: 50%">Descripción </th>
                            <th style="width: 30%">Observaciones </th>
                        </tr>
                        </thead>
                        <tbody >
                        <g:each in="${diagnosticos}" status="i" var="diagnostico">
                            <tr style="width: 100%">
                                <td style="width: 10%">${diagnostico?.diagnostico?.codigo}</td>
                                <td style="width: 50%">${diagnostico?.diagnostico?.descripcion}</td>
                                <td style="width: 30%">${diagnostico?.descripcion}</td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </g:if>
                <g:else>
                    <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> Sin diagnósticos</div>
                </g:else>
            </td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 20%;font-weight: bolder" class="alert alert-warning">Tratamiento:</td>
            <td style="width: 80%; background-color:#ccb35d">
                <g:if test="${tratamientos.size() > 0}">
                    <table class="table table-bordered table-striped table-condensed table-hover">
                        <thead>
                        <tr style="width: 100%">
                            <th style="width: 10%">Medicina </th>
                            <th style="width: 10%">Concentración </th>
                            <th style="width: 10%">Cantidad </th>
                            <th style="width: 35%">Prescripción</th>
                        </tr>
                        </thead>
                        <tbody >
                        <g:each in="${tratamientos}" status="i" var="tratamiento">
                            <tr style="width: 100%">
                                <td style="width: 25%">${tratamiento?.medicina?.codigo ? (tratamiento?.medicina?.codigo  + " - " + tratamiento?.medicina?.descripcion) : ''}</td>
                                <td style="width: 10%">${tratamiento?.medicina?.concentracion}</td>
                                <td style="width: 8%">${tratamiento?.cantidad}</td>
                                <td style="width: 47%">${tratamiento?.descripcion}</td>
                            </tr>
                        </g:each>
                        </tbody>
                    </table>
                </g:if>
                <g:else>
                    <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> Sin tratamiento</div>
                </g:else>
            </td>
        </tr>
        </tbody>
    </table>
</div>

<div class="row" style="margin-top: 20px">
    <div class="col-md-4">
        <span class="badge badge-secondary" style="font-size: 16px">Último Examen Físico</span>
    </div>
</div>

<div id="divExamenFisico">

</div>

<div class="row" style="margin-top: 20px; margin-bottom: 10px">
    <div class="col-md-4">
        <span class="badge badge-secondary" style="font-size: 16px">Citas médicas</span>
    </div>
</div>

<div id="divTablaCitas">

</div>


<script type="text/javascript">

    cargarTablaCitas();

    function cargarTablaCitas() {
        var d = cargarLoader("Cargando...");
        var paciente = '${paciente?.id}';
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'tablaTodasCitas_ajax')}',
            data:{
                id: paciente
            },
            success: function (msg){
                d.modal("hide");
                $("#divTablaCitas").html(msg)
            }
        })
    }

    cargarExamenFisico();

    function cargarExamenFisico() {
        var d = cargarLoader("Cargando...");
        var paciente = '${paciente?.id}';
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'examenFisico_ajax')}',
            data:{
                id: paciente
            },
            success: function (msg){
                d.modal("hide");
                $("#divExamenFisico").html(msg)
            }
        })
    }

</script>


</body>
</html>
