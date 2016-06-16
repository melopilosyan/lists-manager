# @cjsx React.DOM

@ChangeStatusModal = React.createClass
  getInitialState: ->
    close: false
    status: @props.order.status

  changeStatus: ->
    id = @props.order.id
    $.ajax
      url: MOR.order(id)
      type: 'PUT'
      data: {order: {status: @state.status}}
      dataType: 'json'
      success: (data) =>
        if data.status == 'ok'
          @setState close: true
          @props.updateChange(id, @state.status, true)

  onValueChange: (e) ->
    e.preventDefault()
    @setState status: e.target.value

  hintClass: ->
    switch @state.status
      when MO.Statuses.Ordered then 'bg-info'
      when MO.Statuses.Delivered then 'bg-warning'
      when MO.Statuses.Finalized then 'bg-danger'

  hint: ->
    <p className={ 'status-hint ' + @hintClass() } >
      { switch @state.status
          when MO.Statuses.Ordered
            'Fully active state. Allows to edit, add & edit meals.'
          when MO.Statuses.Delivered
            'No edits allowed. Change to Ordered to be able to.'
          when MO.Statuses.Finalized
            "The archived state. Can't be reverted back. Do you realy want this?"
      }
    </p>

  render: ->
    <Modal id='shange-status' buttonText='Change' close={ @state.close }
          title={ 'Order from ' + @props.order.name } action={ @changeStatus } >
      { @hint() }
      <br/>
      <div className='form-group' >
        <label for='change-order-status'>Change status to</label>
        <select id='change-order-status' className='form-control' value={ @state.status } onChange={ @onValueChange } >
          <option value='Ordered'>Ordered</option>
          <option value='Delivered'>Delivered</option>
          <option value='Finalized'>Finalized</option>
        </select>
      </div>
    </Modal>


renderModal = (order, updateChange) ->
  ReactDOM.render <ChangeStatusModal order={ order } updateChange={ updateChange } />, MO.modalContainer

@changeStatusModalLink = (order, updateChange) ->
  linkFor order.status, renderModal.bind(null, order, updateChange)

