
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

<div class="" style="width: 99.7%; overflow-y: auto;float: right; margin-top: 20px">
    <table class="table-bordered table-condensed " style="width: 100%">
        <tbody>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-info">Apellidos:</td>
            <td style="width: 20%; background-color: #b7ebed">${paciente?.apellido}</td>
            <td style="width: 10%" class="alert alert-info">Nombres:</td>
            <td style="width: 20%; background-color: #b7ebed">${paciente?.nombre}</td>
            <td style="width: 10%;" class="alert alert-info">Cédula:</td>
            <td style="width: 20%; background-color: #b7ebed">${paciente?.cedula}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-info">Edad:</td>
            <td style="width: 20%; background-color: #b7ebed">${""}</td>
            <td style="width: 15%" class="alert alert-info">Fecha nacimiento:</td>
            <td style="width: 20%;background-color: #b7ebed">${paciente?.fechaNacimiento?.format("dd-MM-yyyy")}</td>
            <td style="width: 15%;" class="alert alert-info">Lugar nacimiento:</td>
            <td style="width: 20%;background-color: #b7ebed">${""}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-info">Dirección:</td>
            <td style="width: 20%; background-color: #b7ebed">${paciente?.direccion}</td>
            <td style="width: 15%" class="alert alert-info">Teléfono:</td>
            <td style="width: 20%;background-color: #b7ebed">${paciente?.telefono}</td>
            <td style="width: 15%;" class="alert alert-info">Email:</td>
            <td style="width: 20%;background-color: #b7ebed">${paciente?.mail}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 10%" class="alert alert-info">Estado Civil:</td>
            <td style="width: 20%; background-color: #b7ebed">${paciente?.estadoCivil?.descripcion}</td>
            <td style="width: 15%" class="alert alert-info">Sexo:</td>
            <td style="width: 20%;background-color: #b7ebed">${paciente?.sexo == 'M' ? 'MASCULINO' : 'FEMENINO'}</td>
            <td style="width: 15%;" class="alert alert-info">G. Sanguineo:</td>
            <td style="width: 20%;background-color: #b7ebed">${paciente?.grupoSanguineo?.descripcion}</td>
        </tr>
        </tbody>
    </table>
</div>

<div class="" style="width: 99.7%;overflow-y: auto;float: right; margin-top: 20px">
    <table class="table-bordered table-condensed " style="width: 100%">
        <tbody>
        <tr style="font-size: 16px">
            <td style="width: 30%; font-weight: bolder" class="alert alert-success">Antecedentes patológicos personales:</td>
            <td style="width: 70%; background-color: #a2c179">${paciente?.antecedentes}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 30%;font-weight: bolder" class="alert alert-success">Antecedentes patológicos ocupacionales:</td>
            <td style="width: 70%; background-color: #a2c179">${paciente?.antecedentesOcupacionales}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 30%;font-weight: bolder" class="alert alert-success">Antecedentes patológicos familiares:</td>
            <td style="width: 70%; background-color: #a2c179">${paciente?.antecedentesPatologicosFam}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 30%;font-weight: bolder" class="alert alert-success">Antecedentes patológicos gineco obstétricos:</td>
            <td style="width: 70%; background-color: #a2c179">${paciente?.antecedentesGinecobstreticos}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 30%;font-weight: bolder" class="alert alert-success">Hábitos:</td>
            <td style="width: 70%; background-color: #a2c179">${paciente?.habitos}</td>
        </tr>
        </tbody>
    </table>
</div>

<div class="" style="width: 99.7%; overflow-y: auto;float: right; margin-top: 20px">
    <table class="table-bordered table-condensed " style="width: 100%">
        <tbody>
        <tr style="font-size: 16px">
            <td style="width: 30%; font-weight: bolder" class="alert alert-warning">Motivo de la consulta:</td>
            <td style="width: 70%; background-color: #c1bb17">${cita?.motivo}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 30%;font-weight: bolder" class="alert alert-warning">Enfermedad actual:</td>
            <td style="width: 70%; background-color: #c1bb17">${cita?.actual}</td>
        </tr>
        <tr style="font-size: 16px">
            <td style="width: 30%;font-weight: bolder" class="alert alert-warning">Diagnóstico:</td>
            <td style="width: 70%; background-color: #c1bb17">
                <g:if test="${diagnosticos.size() > 0}">
                    <ul>
                        <g:each in="${diagnosticos}" var="diagnostico">
                            <li>
                                ${diagnostico?.diagnostico?.descripcion}
                            </li>
                        </g:each>
                    </ul>
                </g:if>
                <g:else>
                    <div class="alert alert-warning" style="margin-top: 0px; text-align: center; font-size: 14px; font-weight: bold"><i class="fa fa-exclamation-triangle fa-2x text-info"></i> Sin diagnósticos</div>
                </g:else>
            </td>
        </tr>
        </tbody>
    </table>
</div>



</body>
</html>
