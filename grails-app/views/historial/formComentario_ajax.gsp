
<div class="span" role="main">
    <g:uploadForm class="form-horizontal" method="post" name="frmComentario" action="saveComentario_ajax">
        <g:hiddenField name="id" value="${cita?.id}"/>
        <div class="form-group ${hasErrors(bean: 'cita', field: 'comentarioFinal', 'error')} ">
            <span class="grupo">
                <label class="col-md-1 control-label text-info">
                    Comentario Final
                </label>
                <span class="col-md-11">
                    <g:textArea name="comentarioFinal" style="height: 100px; resize: none" maxlength="255" class="form-control" value="${cita?.comentarioFinal}" />
                    <p class="help-block ui-helper-hidden"></p>
                </span>
            </span>
        </div>
    </g:uploadForm>
</div>

<script type="text/javascript">

    $("#frmComentario").validate({
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

</script>
