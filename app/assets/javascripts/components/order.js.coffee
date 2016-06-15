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
    couldBeChanged = @props.user.id == order.creator.id && order.status != MO.Order.Statuses.Finalized

    <tr>
      <th>{ order.id }</th>
      <td>{ linkFor(order.name, showOrderDetails.bind(null, order, @props.user, @props.updateOrders)) }</td>
      <td>{ order.creator.name }</td>
      <td>{ order.madeOn }</td>
      <td>{ if couldBeChanged then changeStatusModalLink(order, @updateOrderChange) else order.status }</td>
      <td width="60" className="text-center">{ @showActionsFor(order) if couldBeChanged }</td>
    </tr>

