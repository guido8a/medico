<g:form class="form-horizontal" name="frmPaciente" controller="paciente" action="savePaciente_ajax">
    <g:hiddenField name="id" value="${paciente?.id}"/>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label for="cedula" class="col-md-2 control-label text-info">
                Cédula
            </label>
            <span class="col-md-3">
                <g:textField name="cedula" maxlength="10" minlength="10" class="form-control allCaps"  value="${paciente?.cedula}"/>
            </span>

%{--            <label for="activo" class="col-md-1 control-label text-info">--}%
%{--                Estado--}%
%{--            </label>--}%
%{--            <span class="grupo">--}%
%{--                <span class="col-md-2">--}%
%{--                    <g:select name="activo" from="${[1: 'Activo' , 0 : 'Inactivo']}" optionKey="key" optionValue="value" class="form-control " value="${paciente?.activo}" />--}%
%{--                </span>--}%
%{--            </span>--}%

%{--            <label class="col-md-1 control-label text-info">--}%
%{--                Foto--}%
%{--            </label>--}%
%{--            <span class="grupo">--}%
%{--                <span class="col-md-2">--}%
%{--                    <a href="#" id="btnFoto" class="btn btn-sm btn-info" title="Foto del paciente">--}%
%{--                        <i class="fa fa-image"></i> Fotografía--}%
%{--                    </a>--}%
%{--                </span>--}%
%{--            </span>--}%

            <label for="numeroHistorial" class="col-md-3 control-label text-info">
                Numero de historia clínica
            </label>
            <span class="col-md-1">
                <g:textField name="numeroHistorial" maxlength="6" class="form-control" style="width: 70px; margin-left: -25px"
                             value="${paciente?.numeroHistorial ?: numeroSiguiente}"/>
            </span>

        </div>
    </div>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label for="nombre" class="col-md-2 control-label text-info">
                Nombres
            </label>
            <span class="grupo">
                <span class="col-md-3">
                    <g:textField name="nombre" minlength="3" maxlength="31" required="" class="form-control required" value="${paciente?.nombre}"/>
                </span>
            </span>
            <label for="apellido" class="col-md-1 control-label text-info">
                Apellidos
            </label>
            <span class="grupo">
                <span class="col-md-3">
                    <g:textField name="apellido" minlength="3" maxlength="31" required="" class="form-control required" value="${paciente?.apellido}"/>
                </span>
            </span>

        </div>
    </div>

    <div class="row izquierda" style="margin-bottom: 15px">
        <div class="col-md-12 input-group">
            <label for="sexo" class="col-md-2 control-label text-info">
                Sexo
            </label>
            <span class="grupo">
                <span class="col-md-2">
                    <g:select name="sexo" from="${['F' :  'FEMENINO', 'M' : 'MASCULINO']}" optionKey="key" optionValue="value" class="form-control" value="${paciente?.sexo}"/>
                </span>
            </span>
%{--            <label for="estadoCivil" class="col-md-2 control-label text-info">--}%
%{--                Estado Civil--}%
%{--            </label>--}%
%{--            <span class="grupo">--}%
%{--                <span class="col-md-2">--}%
%{--                    <g:select name="estadoCivil" from="${medico.EstadoCivil.list()}" optionKey="id" optionValue="descripcion" class="form-control" value="${paciente?.estadoCivil?.id}" noSelection="[null : 'Ninguno']"/>--}%
%{--                </span>--}%
%{--            </span>--}%
            <span class="col-md-2"></span>

            <label for="grupoSanguineo" class="col-md-1 control-label text-info">
                Grupo Sanguíneo
            </label>
            <span class="grupo">
                <span class="col-md-2">
                    <g:select name="grupoSanguineo" from="${medico.GrupoSanguineo.list([sort: 'descripcion'])}" optionKey="id"
                              optionValue="descripcion" class="form-control" value="${paciente?.grupoSanguineo?.id?:0}"
                    />
                </span>
            </span>
        </div>
    </div>

%{--    <div class="row izquierda">--}%
%{--        <div class="col-md-12 input-group">--}%
%{--            <label for="ocupacion" class="col-md-2 control-label text-info">--}%
%{--                Ocupación--}%
%{--            </label>--}%
%{--            <span class="col-md-9">--}%
%{--                <g:textField name="ocupacion" style="resize: none" maxlength="255" class="form-control" value="${paciente?.ocupacion}"/>--}%
%{--            </span>--}%
%{--        </div>--}%
%{--    </div>--}%

    <div class="row izquierda" style="margin-bottom: 15px">
        <div class="col-md-12 input-group">
%{--            <label for="fechaNacimiento" class="col-md-2 control-label text-info">--}%
%{--                Fecha de nacimiento--}%
%{--            </label>--}%
%{--            <span class="grupo" >--}%
%{--                <span class="col-md-2 arriba" >--}%
%{--                    <input aria-label="" name="fechaNacimiento" id='fechaNacimiento' type='text' required=""--}%
%{--                           class="form-control required"  value="${paciente?.fechaNacimiento?.format("dd-MM-yyyy")}" />--}%
%{--                </span>--}%
%{--            </span>--}%
%{--            <span class="col-md-3 text-info">--}%
%{--                <span id="edadCalculo" class="form-control" readonly="" style="margin-left: -20px">--}%
%{--                </span>--}%
%{--            </span>--}%
%{--            <label for="numeroHistorial" class="col-md-3 control-label text-info">--}%
%{--                Numero de historia clínica--}%
%{--            </label>--}%
%{--            <span class="col-md-1">--}%
%{--                <g:textField name="numeroHistorial" maxlength="6" class="form-control" style="width: 70px; margin-left: -25px"--}%
%{--                             value="${paciente?.numeroHistorial ?: numeroSiguiente}"/>--}%
%{--            </span>--}%
        </div>
    </div>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label class="col-md-2 control-label text-info">
                Lugar de nacimiento
                <a href="#" id="btnGeo" class="btn btn-xs btn-info" title="Buscar el lugar de nacimiento">
                    <i class="fa fa-search"></i> Buscar
                </a>
            </label>
            <div class="col-md-2" >Provincia
            <g:textField style="width: 150px;" name="provincia" class="form-control"
                         value="${paciente?.parroquia?.canton?.provincia?.nombre ?: 'PICHINCHA'}" readonly="true" title="Cantón"/>
            </div>

            <div class="col-md-2" style="width: 220px; margin-left: 10px;">Cantón
            <g:textField style="width: 210px;" name="canton" class="form-control"
                         value="${paciente?.parroquia?.canton?.nombre ?: 'QUITO'}" readonly="true" title="Cantón"/>
            </div>

            <span class="grupo" >
                <span class="col-md-2" style="width: 200px; margin-left: 10px;">Parroquia
                <g:hiddenField name="parroquia" value="${paciente?.parroquia?.id ?: 1234}"/>
                <g:textField style="width: 255px;" name="parroquiaNombre" required="" class="form-control required"
                             value="${paciente?.parroquia?.nombre ?: 'TURUBAMBA'}" readonly="true"/>
                </span>
            </span>

        </div>
    </div>
%{--    <div class="row izquierda">--}%
%{--        <div class="col-md-12 input-group">--}%
%{--            <label for="residenciaHabitual" class="col-md-2 control-label text-info">--}%
%{--                Residencia Habitual--}%
%{--            </label>--}%
%{--            <span class="col-md-9">--}%
%{--                <g:textField name="residenciaHabitual" style="resize: none" maxlength="255" class="form-control" value="${paciente?.residenciaHabitual}"/>--}%
%{--            </span>--}%
%{--        </div>--}%
%{--    </div>--}%

%{--    <div class="row izquierda">--}%
%{--        <div class="col-md-12 input-group">--}%
%{--            <label for="residenciaOcasional" class="col-md-2 control-label text-info">--}%
%{--                Residencia Ocasional--}%
%{--            </label>--}%
%{--            <span class="col-md-9">--}%
%{--                <g:textField name="residenciaOcasional" style="resize: none" maxlength="255" class="form-control" value="${paciente?.residenciaOcasional}"/>--}%
%{--            </span>--}%
%{--        </div>--}%
%{--    </div>--}%

%{--    <div class="row izquierda">--}%
%{--        <div class="col-md-12 input-group">--}%
%{--            <label for="direccion" class="col-md-2 control-label text-info">--}%
%{--                Dirección domicilio--}%
%{--            </label>--}%
%{--            <span class="col-md-9">--}%
%{--                <g:textField name="direccion" style="resize: none" maxlength="255" class="form-control" value="${paciente?.direccion}"/>--}%
%{--            </span>--}%
%{--        </div>--}%
%{--    </div>--}%

%{--    <div class="row izquierda">--}%
%{--        <div class="col-md-12 input-group">--}%
%{--            <label for="referencia" class="col-md-2 control-label text-info">--}%
%{--                Referencia de dirección--}%
%{--            </label>--}%
%{--            <span class="col-md-9">--}%
%{--                <g:textField name="referencia" style="resize: none" maxlength="255" class="form-control" value="${paciente?.referencia}"/>--}%
%{--            </span>--}%
%{--        </div>--}%
%{--    </div>--}%

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <label for="telefono" class="col-md-2 control-label text-info">
                Teléfonos
            </label>
            <span class="grupo">
                <span class="col-md-4">
                    <g:textField name="telefono" maxlength="31" class="form-control" value="${paciente?.telefono}"/>
                </span>
            </span>
%{--            <label for="mail" class="col-md-1 control-label text-info">--}%
%{--                Email--}%
%{--            </label>--}%
%{--            <span class="grupo">--}%
%{--                <span class="col-md-4">--}%
%{--                    <g:textField name="mail" maxlength="63" class="email mail form-control" value="${paciente?.mail}"/>--}%
%{--                </span>--}%
%{--            </span>--}%
        </div>
    </div>

%{--    <div class="row izquierda">--}%
%{--        <div class="col-md-12 input-group">--}%
%{--            <label for="responsable" class="col-md-2 control-label text-info">--}%
%{--                Responsable--}%
%{--            </label>--}%
%{--            <span class="col-md-4">--}%
%{--                <g:textField name="responsable" maxlength="255" class="form-control" value="${paciente?.responsable}"/>--}%
%{--            </span>--}%
%{--            <label for="facturar" class="col-md-1 control-label text-info" style="margin-left: -10px; width: 85px">--}%
%{--                Facturar a:--}%
%{--            </label>--}%
%{--            <span class="col-md-4">--}%
%{--                <g:textField name="facturar" maxlength="127" class="form-control" value="${paciente?.facturar}"/>--}%
%{--            </span>--}%
%{--        </div>--}%
%{--    </div>--}%

    <div class="row izquierda">
        <div class="col-md-12 input-group">

        </div>
    </div>

</g:form>

<script type="text/javascript">

    var di;
    var geo;

    $( document ).ready(function() {
        updateanios();
    });

    $('#fechaNacimiento').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        sideBySide: true,
        maxDate: new Date(),
        icons: {
        }
    }).on('dp.change', function(e){
        updateanios();
    });

    function updateanios(){
        var fecha = $("#fechaNacimiento").val();
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'edad_ajax')}',
            data:{
                fecha: fecha
            },
            success: function (msg) {
                $("#edadCalculo").html(msg)
            }
        });
    }

    function validarNum(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            // ev.keyCode === 190 || ev.keyCode === 110 ||
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39);
    }


    $("#btnFoto").click(function () {
        cargarFotoPaciente('${paciente?.id}');
    });

    $("#cedula").keydown(function (ev) {
        return validarNum(ev);
    });

    $("#provincia").change(function () {
        var provincia = $(this).val();
        cargarCanton(provincia);
    });

    cargarCanton($("#provincia option:selected").val());

    function cargarCanton(provincia) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'paciente', action: 'canton_ajax')}',
            data:{
                id: '${paciente?.id}',
                provincia: provincia
            },
            success: function (msg) {
                $("#divCanton").html(msg)
            }
        });
    }

    $("#btnGuardar").click(function () {
        submitFormPaciente();
    });

    function cargarFotoPaciente(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'paciente', action:'foto_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                di = bootbox.dialog({
                    id      : "dlgFoto",
                    title   : "Foto del paciente",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cerrar",
                            className : "btn-gris",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    } //createEdit

    $("#btnGeo").click(function () {
        var id = '${paciente?.id}';
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'paciente', action:'geo_ajax')}",
            data    : {
                id: id
            },
            success : function (msg) {
                geo = bootbox.dialog({
                    id      : "dlgGeo",
                    title   : "Lugar de nacimiento",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "<i class='fa fa-times'></i> Cerrar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    }); //createEdit

    function cerrarDialogoImagen () {
        di.modal("hide");
    }

    function cerrarLugarNacimiento(){
        geo.modal("hide");
    }
</script>