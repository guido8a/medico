<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 10px">
        <fieldset class="borde_abajo" style="position: relative;width: 670px;padding-left: 50px;">
            <div class="linea" style="height: 98%;"></div>
            <p class="css-vertical-text">Archivo</p>
            <g:uploadForm action="uploadDocumento" method="post" name="frmUpload" enctype="multipart/form-data"  >
                <g:hiddenField name="id" value="${base?.id}"/>
                <div class="fieldcontain required">
                    <b>Cargar archivo:</b>
                    <input type="file" id="file" name="file" class="" multiple accept=".jpeg, .jpg, .png, .pdf, .doc, .xls, .xlsx"/>

                    <div class="btn-group" style="margin-top: 20px;">
                        <a href="#" id="submit" class="btn btn-success">
                            <i class="fa fa-save"></i> Guardar
                        </a>
                    </div>
                </div>
            </g:uploadForm>
        </fieldset>
    </fieldset>

    <fieldset class="borde" style="border-radius: 4px">
        <div id="divTabla" >
        </div>
    </fieldset>
</div>

<script type="text/javascript">

    $("#submit").click(function () {
        return submitFormDocumento();
    });

    function submitFormDocumento() {
        var $form = $("#frmUpload");
        var formData = new FormData($("#frmUpload")[0]);
        var dialog = cargarLoader("Guardando...");
        $.ajax({
            type    : "POST",
            url     : $form.attr("action"),
            data    : formData,
            processData: false,
            contentType: false,
            success : function (msg) {
                dialog.modal('hide');
                var parts = msg.split("_");
                if(parts[0] === 'ok'){
                    log(parts[1], "success");
                    cargarTabla();
                }else{
                    bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                    return false;
                }
            }
        });
    }

    cargarTabla();

    function cargarTabla(){
        var e = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'guia', action: 'tablaDocumentos_ajax')}',
            data:{
                id: '${base?.id}'
            },
            success: function (msg){
                e.modal("hide");
                $("#divTabla").html(msg)
            }
        })
    }

</script>