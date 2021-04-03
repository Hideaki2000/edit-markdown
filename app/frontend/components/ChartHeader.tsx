import * as React from "react"


interface IChartHeaderProps {
  title: string;
}

interface IChartHeaderState {
}

class ChartHeader extends React.Component <IChartHeaderProps, IChartHeaderState> {
  render() {
    return (
      <React.Fragment>
        <h2 className="m-4 bg-pink-400 text-lg max-w-xs text-white text-center p-2 rounded-sm">
          {this.props.title}
        </h2>
      </React.Fragment>
    );
  }
}

export default ChartHeader
