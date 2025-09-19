<div class="row">
    <div class="col-md-11 breadcrumb">
        <label class="col-md-12" style="font-size: 20px">2.- Datos de la persona</label>
        <div class="col-md-4 tamano bd">
            Razón Social / Nombres y Apellidos:
        </div>
        <div class="col-md-8 tamano ">
            ${(persona?.apellido ?: '') + " " +  (persona?.nombre)}
        </div>

        <div class="col-md-4 tamano bd">
            Identificación:
        </div>
        <div class="col-md-8 tamano">
            ${persona?.cedula}
        </div>

        <div class="col-md-4 tamano bd">
            Email:
        </div>
        <div class="col-md-8 tamano">
            ${persona?.mail ?: 'SIN EMAIL'}
        </div>

    </div>
    <div class="btn-group col-md-1">
        <a href="#" class="btn btn-sm btn-success btnEditarDatosPersona" data-id="${persona?.id}" title="Editar información de la persona">
            <i class="fas fa-edit"></i> Editar
        </a>
    </div>
</div>

