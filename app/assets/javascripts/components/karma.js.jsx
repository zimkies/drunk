var Karma = React.createClass({
  propTypes: {
    positive_karma: React.PropTypes.number,
    negative_karam: React.PropTypes.number,
    vice: React.PropTypes.string,
  },

  renderKarmaText: function () {
    if (this.aboveViceThreshold()) {
      return <h3>You are above your {this.props.vice} limit! No {this.props.vice} for you</h3>
    } else if (this.aboveVirtueThreshold()) {
      return <h3>Your life is in balance! Nice work :D</h3>
    } else {
      return <h3>Great job! you are way over your virtue quota. Why not spend some time #{this.props.vice} today?</h3>
    };
  },

  aboveViceThreshold: function() {
    return this.props.karma > 3
  },

  aboveVirtueThreshold: function() {
    return this.props.karma > -3
  },

  render: function() {
    return (
      <div>
        {this.renderKarmaText()}
        <div className="row">
          <div className="col-xs-6 karma-column vice-column">
            Vice Count: {this.props.negative_karma}
            <button onClick={this.onClickAddKarma} className="btn add-karma add-vice">+</button>
          </div>
          <div className="col-xs-6 karma-column virtue-column">
            Virtue Count: {this.props.positive_karma}
            <button className="btn add-karma add-virtue">+</button>
          </div>
        </div>
      </div>
    );
  },

  onClickAddKarma: function() {
    $.ajax()
  },
});
