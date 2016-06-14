# @cjsx React.DOM

@Order = React.createClass
  updateOrderEdit: (id, newValue) ->
    order = $.extend true, {}, @props.order
    order.name = newValue
    @props.updateOrders order

  updateOrderChange: (newValue) ->
    order = $.extend true, {}, @props.order
    order.status = newValue
    @props.updateOrders order

  showActionsFor: (order) ->
    if order.creator.id == @props.user.id
      actionIconsFor order, @updateOrderEdit, @props.updateOrders

  render: ->
    order = @props.order

    <tr>
      <th>{ order.id }</th>
      <td>{
        @props.user.authenticated &&
          linkFor(order.name, showOrderDetails.bind(null, order, @props.user, @props.updateOrders)) ||
          order.name
      }</td>
      <td>{
        @props.user.authenticated && changeStatusModalLink(order, @updateOrderChange) || order.status
      }</td>
      <td>{ order.creator.name }</td>
      <td>{ order.madeOn }</td>
      <td>{ @showActionsFor(order) }</td>
    </tr>

