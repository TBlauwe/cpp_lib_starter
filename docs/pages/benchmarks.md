# Benchmarks

This page showcase how to integrate charts from our "continuous benchmarking"

## Usage

First, let's assume we have the following:

* Some benchmarking, like `BM_Success`
* Severals results of those benchmarking

> We recommand using `run_benchmark.py` as it will input additional information.

By writing :

```
@iframe my_plot.html 800 600

@htmlonly
<iframe src="my_plot.html" width="800" height="600"></iframe>
@endhtmlonly
```

@iframe my_plot.html 800 600

@htmlonly
<iframe src="my_plot.html" width="800" height="600"></iframe>
@endhtmlonly


Alternatively, you can script plot directly :

```
@htmlonly
<div id="gd"></div>

<script>
	Plotly.newPlot("gd", /* JSON object */ {
		"data": [{ "y": [1, 2, 3] }],
		"layout": { "width": 600, "height": 400}
	})
</script>
@endhtmlonly
```

@htmlonly
<div id="gd"></div>

<script>
	Plotly.newPlot("gd", /* JSON object */ {
		"data": [{ "y": [1, 2, 3] }],
		"layout": { "width": 600, "height": 400}
	})
</script>
@endhtmlonly
