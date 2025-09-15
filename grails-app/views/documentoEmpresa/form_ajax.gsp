<g:form class="form-horizontal" name="frmDocumentoEmpresa" role="form" action="save_ajax" method="POST">
    <g:hiddenField name="id" value="${documentoEmpresaInstance?.id}" />
    <g:hiddenField name="empresa" value="${empresa?.id}" />

    <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'empresa', 'error')} ">
        <span class="grupo">
            <label for="empresaNombre" class="col-md-3 control-label text-info">
                Empresa
            </label>
            <span class="col-md-6">
                <g:textField name="empresa.nombre" id="empresaNombre" value="${empresa?.nombre}" class="form-control" readonly="true"/>
            </span>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'tipo', 'error')} ">
        <span class="grupo">
            <label for="tipo" class="col-md-3 control-label text-info">
                Tipo
            </label>
            <span class="col-md-6">
                <g:select name="tipo" from="${['F':'Factura', "R": 'Retención', "ND": 'Nota de Débito', "NC": 'Nota de Crédito']}" optionKey="key" optionValue="value" class="form-control required" value="${documentoEmpresaInstance?.tipo}"/>
            </span>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'autorizacion', 'error')} ">
        <span class="grupo">
            <label for="autorizacion" class="col-md-3 control-label text-info">
                Autorización
            </label>
            <span class="col-md-6">
                <g:textField name="autorizacion" required="" class="allCaps form-control required validacionNumeroSinPuntos"
                             value="${documentoEmpresaInstance?.autorizacion}" maxlength="10"/>
            </span>

        </span>
    </div>
    <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'numeroEstablecimiento', 'error')} ">
        <span class="grupo">
            <label class="col-md-3 control-label text-info">
                Sucursal
            </label>
            <span id="divSucursal">
%{--                <g:select class="form-control required cmbRequired" name="numeroEstablecimiento" id="numeroEstablecimiento"--}%
%{--                          from="${establecimientos}" label="Proceso tipo: " value="${documentoEmpresaInstance?.numeroEstablecimiento}" optionKey="id"--}%
%{--                          optionValue="${{it.numero + " - " + it.nombre}}" title="Sucursales" />--}%
            </span>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'numeroEmision', 'error')} ">
        <span class="grupo">
            <label for="numeroEmision" class="col-md-3 control-label text-info">
                Número Emisión
            </label>
            <span class="col-md-4">
                <g:textField name="numeroEmision" required="" maxlength="10" class="form-control validacionNumeroSinPuntos required" value="${documentoEmpresaInstance?.numeroEmision}"/>
            </span>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'numeroDesde', 'error')} ">
        <span class="grupo">
            <label for="numeroDesde" class="col-md-3 control-label text-info">
                Número Desde
            </label>
            <span class="col-md-4">
                <g:textField name="numeroDesde" maxlength="15" value="${documentoEmpresaInstance.numeroDesde}" class="form-control validacionNumeroSinPuntos required" required=""/>
            </span>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'digitosEnSecuencial', 'error')} ">
        <span class="grupo">
            <label for="digitosEnSecuencial" class="col-md-3 control-label text-info">
                Dígitos En Secuencial
            </label>
            <span class="col-md-4">
                <g:textField name="digitosEnSecuencial"  required="" class="form-control validacionNumeroSinPuntos required" value="${documentoEmpresaInstance?.digitosEnSecuencial}"/>

            </span>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'numeroHasta', 'error')} ">
        <span class="grupo">
            <label for="numeroHasta" class="col-md-3 control-label text-info">
                Número Hasta
            </label>
            <span class="col-md-4">
                <g:textField name="numeroHasta" maxlength="15" value="${documentoEmpresaInstance.numeroHasta}" class="form-control validacionNumeroSinPuntos required" required=""/>
            </span>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'fechaAutorizacion', 'error')} ">
        <span class="grupo">
            <label for="datetimepicker1" class="col-md-3 control-label text-info">
                Fecha Autorización
            </label>
            <span class="col-md-4">
                <input name="fechaAutorizacion" id='datetimepicker1' type='text' class="form-control required" value="${documentoEmpresaInstance?.fechaAutorizacion?.format("dd-MM-yyyy")}"/>
            </span>
        </span>
    </div>
    <div class="form-group ${hasErrors(bean: documentoEmpresaInstance, field: 'fechaFin', 'error')} ">
        <span class="grupo">
            <label for="datetimepicker2" class="col-md-3 control-label text-info">
                Válido Hasta
            </label>
            <span class="col-md-4">
                <input name="fechaFin" id='datetimepicker2' type='text' class="form-control required" value="${documentoEmpresaInstance?.fechaFin?.format("dd-MM-yyyy")}"/>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">
    
    $('#datetimepicker1, #datetimepicker2').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        showClose: true,
        icons: {
            close: 'closeText'
        }
    });

    cargarSucursales();
    
    function cargarSucursales() {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'documentoEmpresa', action: 'sucursal_ajax')}',
            data:{
                id: '${documentoEmpresaInstance?.id}',
                empresa: '${empresa?.id}'
            },
            success: function (msg){
                $("#divSucursal").html(msg)
            }
        })
    }
    
    var validator = $("#frmDocumentoEmpresa").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
        }
    });
    $(".form-control").keydown(function (ev) {
        if (ev.keyCode === 13) {
            submitForm();
            return false;
        }
        return true;
    });

    function validarNumSinPuntos(ev) {
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
            ev.keyCode === 8 || ev.keyCode === 46 || ev.keyCode === 9 ||
            ev.keyCode === 37 || ev.keyCode === 39 );
    }

    $(".validacionNumeroSinPuntos").keydown(function (ev) {
        return validarNumSinPuntos(ev);
    }).keyup(function () {
    });

</script>