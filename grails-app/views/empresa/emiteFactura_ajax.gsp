<asset:javascript src="/Toggle-Button-Checkbox/js/bootstrap-checkbox.js"/>

<g:form class="form-horizontal" name="frmEmpresaCont" role="form" action="saveFormContabilidad_ajax" method="POST">
    <g:hiddenField name="id" value="${empresa?.id}"/>
        <div class="form-group keeptogether ${hasErrors(bean: empresa, field: 'factura', 'error')} ">
            <span class="grupo">
                <label for="factura" class="col-xs-6 control-label text-info">
                   Su consultorio emite facturas?
                </label>
                <span class="col-xs-6">
                    <g:checkBox name="factura_name" id="factura" class="form-control" data-on-Label="Si" checked="${empresa?.factura == 'S' ?: false}"/>
                </span>
            </span>
        </div>
</g:form>

<script type="text/javascript">

    $(function() {
        $("#factura").checkboxpicker({
        });
    });

</script>