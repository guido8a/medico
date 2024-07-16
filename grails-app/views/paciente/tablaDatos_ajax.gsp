<div class="" style="width: 99.7%; overflow-y: auto;float: right; margin-top: 10px; margin-bottom: 0px">
    <div style="width: 3%; float: left; margin-right: 5px">
        <a href="#" class="btn btn-info col-md-12" role="alert" id="btnEditaPaciente" title="Editar los datos de afiliación">
            <i class="fas fa-edit"></i>
        </a>
    </div>
    <div style="width:96%; float: left">
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
                <td style="width: 20%; background-color: #c1cfe7">${edad} ${paciente.ninoNina ? " - " + paciente.ninoNina : ''} ${paciente.obstetricia? 'Obst.':''}</td>
                <td style="width: 15%" class="alert alert-info">Fecha nacimiento:</td>
                <td style="width: 20%;background-color: #c1cfe7">${paciente?.fechaNacimiento?.format("dd-MM-yyyy")}</td>
                <td style="width: 15%;" class="alert alert-info">Lugar nacimiento:</td>
                <td style="width: 20%;background-color: #c1cfe7">${paciente.parroquia.nombre}</td>
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
</div>


<script type="text/javascript">
    $("#btnEditaPaciente").click(function () {
       editaPaciente();
    });

</script>