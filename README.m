<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <script src="https://cdn.jsdelivr.net/npm/mermaid@10/dist/mermaid.min.js"></script>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      background: transparent;
      margin: 0;
      padding: 10px;
    }
  </style>
</head>
<body>
  <div id="graph-container"></div>

  <script>
    function getMoonPhase() {
      const date = new Date();
      let year = date.getFullYear();
      let month = date.getMonth() + 1;
      let day = date.getDate();

      if (month < 3) {
        year--;
        month += 12;
      }
      month++;

      const c = 365.25 * year;
      const e = 30.6 * month;
      const jd = c + e + day - 694039.09;
      const b = jd / 29.5305882;
      const phase = b - Math.floor(b);
      
      return Math.round((1 - Math.cos(phase * 2 * Math.PI)) / 2 * 100);
    }

    const hojeIluminacao = getMoonPhase();

    const graphDefinition = `
      xychart-beta
      title "Onde estamos no ciclo lunar"
      x-axis ["Nova", "Quarto crescente", "Agora", "Cheia"]
      y-axis "Iluminação (%)" 0 --> 100
      line [0, 50, ${hojeIluminacao}, 100]
    `;

    mermaid.initialize({ startOnLoad: false, theme: 'default' });

    document.addEventListener("DOMContentLoaded", async () => {
      const element = document.getElementById('graph-container');
      const { svg } = await mermaid.render('mermaidGraph', graphDefinition);
      element.innerHTML = svg;
    });
  </script>
</body>
</html>
