# 🛒 NexusIQ — E-Commerce Sales & Customer Analytics Platform

<div align="center">

![NexusIQ Banner](https://img.shields.io/badge/NexusIQ-Analytics%20Platform-1D9E75?style=for-the-badge&logo=data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZmlsbD0id2hpdGUiIGQ9Ik0xMiAyQzYuNDggMiAyIDYuNDggMiAxMnM0LjQ4IDEwIDEwIDEwIDEwLTQuNDggMTAtMTBTMTcuNTIgMiAxMiAyek0xMSAxN2wtNS01IDEuNDEtMS40MUwxMSAxNC4xN2w3LjU5LTcuNTlMMjAgOGwtOSA5eiIvPjwvc3ZnPg==)

[![Live Demo](https://img.shields.io/badge/Live%20Demo-View%20Dashboard-378ADD?style=for-the-badge)](https://your-demo-link.com)
[![MIT License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)](LICENSE)
[![JavaScript](https://img.shields.io/badge/JavaScript-ES6+-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)](https://developer.mozilla.org/en-US/docs/Web/JavaScript)
[![Chart.js](https://img.shields.io/badge/Chart.js-4.4-FF6384?style=for-the-badge&logo=chart.js&logoColor=white)](https://www.chartjs.org/)
[![D3.js](https://img.shields.io/badge/D3.js-7.8-F9A03C?style=for-the-badge&logo=d3.js&logoColor=white)](https://d3js.org/)

**A production-grade, fully interactive e-commerce analytics dashboard built with vanilla HTML, CSS, and JavaScript. No frameworks. No build tools. Just open and run.**

</div>

---

## 📸 Screenshots

> **Dashboard Overview — KPIs, Revenue Charts & Category Breakdown**

```
┌─────────────────────────────────────────────────────────────────┐
│  NexusIQ  │ Overview │ Customers │ Products │ Regional │ Advanced │
├─────────────────────────────────────────────────────────────────┤
│  $2.84M        14,293        $891K        $198         ● Live   │
│  Revenue       Orders        Profit       Avg AOV               │
├──────────────────────────────┬──────────────────────────────────┤
│  Monthly Revenue & Orders    │  Revenue by Category             │
│  [Bar Chart — Jan–Dec 2024]  │  [Donut: Electronics 38%]       │
├──────────────────────────────┴──────────────────────────────────┤
│  Daily Order Volume          │  Profit Margin Trend             │
│  [Line — Last 30 days]       │  [Line — Monthly %]              │
└─────────────────────────────────────────────────────────────────┘
```

> **Customer Analytics — Segments, Cohort Retention & Top Buyers**

```
┌─────────────────────────────────────────────────────────────────┐
│  8,421 Customers │ 3,876 Repeat │ 68.3% Retention │ $1,247 LTV │
├──────────────────────────────┬──────────────────────────────────┤
│  Top Customers by Revenue    │  Customer Retention Cohorts      │
│  [Table with RFM Segments]   │  [Multi-line cohort chart]       │
├──────────────────────────────┴──────────────────────────────────┤
│  Repeat vs New Customers — Monthly Stacked Bar Chart            │
└─────────────────────────────────────────────────────────────────┘
```

> **Regional Analytics — Interactive US Revenue Heatmap**

```
┌─────────────────────────────────────────────────────────────────┐
│  Top City: New York  │  Top State: California  │  Growth: Texas │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│         [Interactive D3.js Choropleth Map — Hover States]       │
│         🟢 Low  🟩 Mid  🟦 High Revenue                          │
│                                                                 │
├──────────────────────────────┬──────────────────────────────────┤
│  Top Cities Table            │  Revenue by US Region (Bar)      │
└──────────────────────────────┴──────────────────────────────────┘
```

> **Advanced Analytics — Forecasting, Segmentation & AI Insights**

```
┌─────────────────────────────────────────────────────────────────┐
│  Sales Forecast — Next 6 Months (with confidence bands)         │
│  [Actual ——  Forecast - - -  Confidence Band ░░░]               │
├─────────────────────────────────────────────────────────────────┤
│  Customer Segmentation (RFM Analysis)                           │
│  Champions 1,203 │ Loyal 2,419 │ At-Risk 634 │ New 1,287       │
├──────────────────────────────┬──────────────────────────────────┤
│  Recommendation Insights     │  Profit Margin Analysis          │
│  Cross-sell / Up-sell / Bundle│ [Gross vs Net line chart]       │
└──────────────────────────────┴──────────────────────────────────┘
```

---

## ✨ Features

### 📊 Sales KPIs
- **Total Revenue** with quarter-over-quarter comparison
- **Total Orders** with trend indicators
- **Net Profit** with margin growth tracking
- **Average Order Value** with directional arrows

### 👥 Customer Analytics
- **Top customers** ranked by lifetime value with RFM tags
- **Repeat vs new** customer breakdown — monthly stacked bar chart
- **Cohort retention** curves — track how each cohort retains over 12 months
- **Customer retention rate** and average LTV metrics

### 📦 Product Analytics
- **Best-selling products** table with units, revenue, and trend
- **Low-performing products** flagged with action suggestions (Discount / Bundle / Review)
- **Profit margin by category** — horizontal bar visualization
- **Top 8 products** horizontal bar chart

### 🗺️ Regional Analytics
- **Interactive D3.js choropleth** — hover over any US state to see revenue
- **Top cities table** with revenue and order counts
- **Revenue by region** (Northeast / West / South / Midwest / Southwest)
- Color-coded heatmap with three intensity bands

### 🤖 Advanced Add-ons
| Feature | Description |
|---|---|
| **Sales Forecasting** | 6-month AI-style prediction with upper/lower confidence bands |
| **Customer Segmentation** | RFM model — Champions, Loyal, Potential, At-Risk, Hibernating, New |
| **Recommendation Insights** | Cross-sell, up-sell, bundle, and trending product insights |
| **Profit Margin Analysis** | Gross vs net margin trend — monthly comparison line chart |

---

## 🚀 Getting Started

### Prerequisites

No build tools, no npm, no frameworks needed. Just a browser.

```bash
git clone https://github.com/YOUR_USERNAME/nexusiq-analytics.git
cd nexusiq-analytics
```

Then open `index.html` in any modern browser.

Or serve locally with Python:

```bash
# Python 3
python -m http.server 8000
# Visit http://localhost:8000
```

Or with Node.js:

```bash
npx serve .
```

---

## 🗂️ Project Structure

```
nexusiq-analytics/
│
├── index.html          # Main dashboard (single-file app)
├── README.md           # This file
├── LICENSE             # MIT License
│
└── assets/             # (optional) screenshots, logos
    └── preview.png
```

> This is a **single-file application**. All HTML, CSS, and JavaScript lives in `index.html` — easy to deploy anywhere.

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Structure | HTML5 (semantic) |
| Styling | CSS3 with custom properties (light/dark mode) |
| Charts | [Chart.js 4.4](https://www.chartjs.org/) |
| Maps | [D3.js 7.8](https://d3js.org/) + [TopoJSON 3](https://github.com/topojson/topojson) |
| Map Data | [US Atlas](https://github.com/topojson/us-atlas) (CDN) |
| Icons | [Tabler Icons](https://tabler-icons.io/) (outline, CDN) |
| Typography | [DM Mono](https://fonts.google.com/specimen/DM+Mono) + [Fraunces](https://fonts.google.com/specimen/Fraunces) |
| Hosting | GitHub Pages / Netlify / Vercel — any static host |

---

## 📐 Architecture & Design Decisions

### Why single-file?
- Zero configuration — clone and open
- Easy to share as a GitHub Gist or CodePen
- No build step means no broken pipelines

### Why Chart.js + D3.js?
- **Chart.js** for standard charts (bar, line, donut) — easy API, responsive by default
- **D3.js** only for the choropleth map — it's the right tool for geographic projections
- Both load via CDN so there's nothing to install

### Light/dark mode
The dashboard uses CSS custom properties (`--color-text-primary`, `--color-background-primary`, etc.) which adapt automatically to the user's system preference via `prefers-color-scheme`.

---

## 📊 Data

All data in this demo is **realistic synthetic data** — representative of a mid-size e-commerce business generating ~$2–3M/year.

To connect real data:

1. Replace the hardcoded arrays in the `<script>` section with API calls
2. Use `fetch('/api/sales-kpis')` or similar endpoints
3. All chart instances are assigned to named variables — easy to update with `.data.datasets[0].data = newData; chart.update()`

---

## 🌐 Deploy in 60 Seconds

### GitHub Pages
1. Push to GitHub
2. Go to **Settings → Pages**
3. Set source to `main` branch, `/ (root)`
4. Your dashboard is live at `https://yourusername.github.io/nexusiq-analytics`

### Netlify (drag & drop)
1. Go to [netlify.com/drop](https://app.netlify.com/drop)
2. Drag your project folder in
3. Done — instant live URL

---

## 🧩 Customization Guide

### Change KPI values
Find the `.kpi-value` sections in `index.html` and update the text content.

### Add a new chart
```javascript
new Chart(document.getElementById('myNewChart'), {
  type: 'bar',
  data: {
    labels: ['A', 'B', 'C'],
    datasets: [{ data: [10, 20, 30], backgroundColor: '#1D9E75' }]
  },
  options: { responsive: true, maintainAspectRatio: false }
});
```

### Change the color theme
Edit the `:root` CSS variables at the top of the `<style>` block:
```css
:root {
  --accent: #1D9E75;   /* primary green */
  --accent2: #3266AD;  /* blue */
  --warn: #BA7517;     /* amber */
}
```

### Add a new nav section
1. Add a button to `.topbar-nav`
2. Add a `<div class="page" id="page-yourname">` block
3. Call `showPage('yourname')` in the button's `onclick`

---

## 🤝 Contributing

Contributions are welcome! Here's how:

```bash
# 1. Fork the repo
# 2. Create your feature branch
git checkout -b feature/amazing-feature

# 3. Commit your changes
git commit -m "Add amazing feature"

# 4. Push to your branch
git push origin feature/amazing-feature

# 5. Open a Pull Request
```

### Ideas for contributions
- [ ] Export charts as PNG / PDF
- [ ] CSV data import
- [ ] Date range picker filter
- [ ] Mobile responsive sidebar nav
- [ ] Dark mode toggle button
- [ ] More chart types (scatter, funnel, waterfall)

---

## 📄 License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

You are free to use this in personal projects, commercial projects, portfolios, and client work.

---

## 🙋 FAQ

**Q: Can I use this for a real business?**  
Yes. Replace the hardcoded data with your API responses and deploy.

**Q: Does it work on mobile?**  
The layout is desktop-first. Mobile support is a planned enhancement — PRs welcome!

**Q: Is there a backend?**  
No — this is a pure frontend demo. You supply the data.

**Q: Can I use a different charting library?**  
Absolutely. Recharts, Plotly, ApexCharts, ECharts — the HTML structure stays the same; just swap the chart initialization code.

---

<div align="center">

Built with ❤️ — feel free to ⭐ star this repo if it helped you!

[![GitHub stars](https://img.shields.io/github/stars/YOUR_USERNAME/nexusiq-analytics?style=social)](https://github.com/YOUR_USERNAME/nexusiq-analytics)

</div>
