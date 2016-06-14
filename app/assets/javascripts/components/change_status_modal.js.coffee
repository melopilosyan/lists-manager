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
        log 'changeStatus ajax succeeded', data
        if data.status == 'ok'
          @setState close: true
          @props.updateChange(@state.status)

  onValueChange: (e) ->
    e.preventDefault()
    @setState status: e.target.value

  render: ->
    <Modal id='shange-status' buttonText='Change' close={ @state.close }
          title={ 'Change ' + @props.order.name + " order's status" } action={ @changeStatus } >
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

