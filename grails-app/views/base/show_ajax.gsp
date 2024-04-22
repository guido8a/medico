
<style type="text/css">

    .texto-verde {
        color: #186063;
    }
    .texto-azul {
        color: #1d63b0;
        font-weight: bold;
    }
</style>


<g:if test="${!baseInstance}">
    <elm:notFound elem="Base" genero="o" />
</g:if>
<g:else>

    <g:if test="${baseInstance?.subtema}">
        <div class="alert alert-info" style="padding: 10px; height: 35px" role="alert">
            <span class="col-md-4 texto-verde">
                <strong>Especialidad: </strong> ${baseInstance?.subtema?.tema?.nombre}
            </span>
            <span class="col-md-4 texto-verde">
                <strong>Tipología extra: </strong> ${baseInstance?.subtema?.nombre}
            </span>
            <span class="col-md-4 texto-verde">
                <strong>Fuente: </strong> ${baseInstance?.organizacion}
            </span>
        </div>
    </g:if>



    <g:if test="${baseInstance?.enfermedad}">
        <div class="alert alert-dismissible alert-success" style="font-size: 16px; margin-top: -10px">
            <div>
                <strong>Enfermedad:</strong>
                ${baseInstance?.enfermedad}
            </div>
            <div>
                <strong>Problema:</strong>
                ${baseInstance?.problema}
            </div>
        </div>
    </g:if>

    %{--<g:if test="${baseInstance?.problema}">--}%
        %{--<div class="alert alert-dismissible alert-success" style="font-size: 16px;">--}%
            %{--<strong>Problema:</strong>--}%
            %{--${baseInstance?.problema}--}%
        %{--</div>--}%
    %{--</g:if>--}%

    <g:if test="${baseInstance?.solucion}">
        <div class="alert alert-dismissible alert-info" style="font-size: 15px;">
            <strong>Solución:</strong>
            ${baseInstance?.solucion}
        </div>
    </g:if>

    <g:if test="${lista.size() > 0}">
        <div class="alert alert-dismissible alert-warning" style="font-size: 15px;">
            <i class="fa fa-2x fa-exclamation-triangle"></i>  Este tema contiene <strong>${lista.size()}</strong> imágenes o archivos asociados.
        </div>
    </g:if>


    <div class="container" style="margin-bottom: 10px">
        <div class="col-xs-9" style="background: #eeeeee; max-height: 400px; overflow: auto; padding: 20px;">
            <strong>Procedimiento médico:</strong>
            <util:renderHTML html="${baseInstance.algoritmo}"/>
        </div>
    </div>

    <g:if test="${baseInstance?.referencia}">
        <div class="row">
            <div class="col-md-1" style="font-weight: bolder">
                Referencias:
            </div>
            <div class="col-md-11 texto-azul">
                <util:separar urls="${baseInstance.referencia}"/>
            </div>
        </div>
    </g:if>

    <g:if test="${baseInstance?.observacion}">
        <div class="container" style="margin-bottom: 10px">
            <div class="col-xs-9" style="background: #eeeeee; max-height: 400px; overflow: auto; padding: 20px;">
                <strong>Observaciones:</strong>
                <util:renderHTML html="${baseInstance.observacion}"/>
            </div>
        </div>
    </g:if>

    %{--<g:if test="${baseInstance?.organizacion}">--}%
        %{--<div class="row">--}%
            %{--<div class="col-md-12 texto-verde">--}%
                %{--<strong>Fuente: </strong> ${baseInstance?.organizacion}--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</g:if>--}%

    %{--<g:if test="${baseInstance?.enfermedad}">--}%
        %{--<div class="container" style="margin-bottom: 10px">--}%
            %{--<div class="col-xs-9" style="background: #eeeeee; max-height: 400px; overflow: auto; padding: 20px;">--}%
                %{--<strong>Enfermedad:</strong>--}%
                %{--<util:renderHTML html="${baseInstance.enfermedad}"/>--}%
            %{--</div>--}%
        %{--</div>--}%
    %{--</g:if>--}%

    <g:if test="${baseInstance?.clave}">
        <div class="row">
            <div class="col-md-12 texto-verde">
                <strong>Palabras Clave:</strong><g:fieldValue bean="${baseInstance}" field="clave"/>
            </div>
        </div>
    </g:if>

    <g:if test="${baseInstance?.fecha}">
        <div class="row">
            <div class="col-md-12" style="text-align: right">
                Creado el <g:formatDate date="${baseInstance?.fecha}" format="dd-MMM-yyyy" />
                por: ${baseInstance?.persona?.nombre} ${baseInstance?.persona?.apellido},
                dentro del tema: <span class="texto-verde"> "${baseInstance?.subtema?.nombre?.encodeAsHTML()}"</span>
            </div>
            
        </div>
    </g:if>
    
</g:else>