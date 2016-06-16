# @cjsx React.DOM

@OrdersContainer = React.createClass
  getDefaultProps: ->
    type: 'active'

  getInitialState: ->
    orders: []
    loading: true

  componentWillMount: ->
    @requestOrders()

  componentWillReceiveProps: (props) ->
    log 'self auth:', @props.authenticated, 'received outh:', props.authenticated
    if !@props.authenticated && props.authenticated
      @requestOrders()

  requestOrders: ->
    @setState loading: true
    $.getJSON MOR.orders_url(), {type: @props.type}, (data) =>
      @props.informReload && @props.informReload()
      @setState orders: data.orders, loading: false

  updateOrders: (order, add, checkStatus) ->
    remove = (orderId) =>
      @state.orders.filter (o) -> o.id != orderId

    if typeof order == 'object'
      if checkStatus && order.status == MO.Statuses.Finalized
        orders = remove(order.id)
        @props.onHasFinalized(true)
      else
        orders = add && [order].concat(@state.orders) ||
                  @state.orders.map (ord) -> order.id == ord.id && order || ord
    else
      orders = remove(order)
    @setState orders: orders

  allowChange: ->
    @props.authenticated && @props.type == 'active'

  addNewBtn: (cls) ->
    if @allowChange()
        makeOrderButton(@updateOrders, cls)

  pleaseSignIn: ->
    <footer>Please login with FaceBook to be able to make orders</footer>

  noOrdersMsg: ->
    <blockquote>
      <p>There are no orders in this section</p>
      { @pleaseSignIn() if @props.type == 'active' && !@props.authenticated }
    </blockquote>

  orders: ->
    <Orders
      type={ @props.type }
      orders={ @state.orders }
      authenticated={ @props.authenticated }
      allowEdit={ @allowChange() }
      updateOrders={ @updateOrders } />

  render: ->
    btnsCls = 'btn btn-primary btn-xs'

    <div className='row'>
      <div className='col-md-12'>
        <div className='card'>
          <div className='card-block'>
            <h2 className="card-title">
              { @props.type == 'active' && 'Active orders' || 'Archived orders' }
              <span className="pull-right">
                {[ @addNewBtn btnsCls
                   <i key='s1' className='space'></i>
                   linkFor 'Reload', btnsCls, @requestOrders ]}
              </span>
            </h2>
          </div>
          <div className='card-block'>
            <div className='box'>
              { if @state.loading then <Loader /> else if @state.orders.length then @orders() else @noOrdersMsg() }
            </div>
          </div>
        </div>
      </div>
    </div>


