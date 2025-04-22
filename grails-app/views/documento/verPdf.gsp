<!doctype html>
<html>
<head>
    <meta name="layout" content="main">
    <title>
        Documento PDF
    </title>
</head>
<body>

<div class="row" style="margin-bottom: 20px">
    <div class="col-md-3 btn-group">
        <g:link controller="documento" action="biblioteca" class="btn btn-primary">
            <i class="fa fa-arrow-left"></i> Regresar
        </g:link>
    </div>
    <div class="col-md-9"></div>
</div>

<div style="overflow: hidden">
    <fieldset class="borde" style="border-radius: 4px; margin-bottom: 10px">
        <embed src="${createLink(controller: 'documento', action: 'downloadFile', id: documento?.id)}" style="width: 100%; height: 600px" type='application/pdf'>
    </fieldset>
</div>

<script type="text/javascript">


</script>

</body>
</html>