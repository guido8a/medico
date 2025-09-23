
<div >
    <div class="col-md-12 breadcrumb">
        <div class="row">
            <div class="col-md-4 text-info">
                Grupo
            </div>

            <div class="col-md-8">
                ${producto?.subgrupo?.grupo?.descripcion ?: ''}
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 text-info">
                Subgrupo
            </div>

            <div class="col-md-8">
                ${producto?.subgrupo?.descripcion ?: ''}
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 text-info">
                Nombre
            </div>

            <div class="col-md-8">
                ${producto?.texto ?: ''}
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 text-info">
                Marca
            </div>

            <div class="col-md-8">
                ${producto?.marca?.descripcion ?: 'Sin Marca'}
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 text-info">
                Precio Unitario
            </div>

            <div class="col-md-8">
                ${producto?.precioUnitario ?: ''}
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 text-info">
                Tipo IVA
            </div>

            <div class="col-md-8">
                ${producto?.tipoIva?.descripcion ?: ''}
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 text-info">
                Orden
            </div>

            <div class="col-md-8">
                ${producto?.numero ?: ''}
            </div>
        </div>
        <div class="row">
            <div class="col-md-4 text-info">
                Fecha de modificación
            </div>

            <div class="col-md-8">
                ${producto?.fechaModificacion?.format("dd-MM-yyyy") ?: ''}
            </div>
        </div>
    </div>
</div>

