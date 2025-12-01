# ============================================================================
# DASHBOARD - ANÁLISIS DE CONGESTIÓN VEHICULAR EN SANTIAGO
# Minería de Datos 2025
# Autor: Javier Farías
# Universidad Andrés Bello - Ingeniería Civil Informática
# ============================================================================

library(shiny)
library(shinydashboard)
library(DT)
library(plotly)
library(ggplot2)

# ============================================================================
# INTERFAZ DE USUARIO (UI)
# ============================================================================

ui <- dashboardPage(
  skin = "purple",
  
  dashboardHeader(
    title = span(
      icon("car"), 
      "Análisis de Congestión Vehicular"
    ),
    titleWidth = 350
  ),
  
  dashboardSidebar(
    width = 280,
    
    # Info del equipo en sidebar
    div(
      style = "padding: 15px; text-align: center; border-bottom: 1px solid #444;",
      h4(style = "color: #fff; margin-bottom: 5px;", "Autor"),
      p(style = "color: #aaa; font-size: 12px; margin: 0;", "Javier Farías"),
      p(style = "color: #888; font-size: 11px; margin-top: 5px;", "UNAB - Ing. Civil Informática")
    ),
    
    sidebarMenu(
      id = "tabs",
      
      # SECCIÓN 1: INTRODUCCIÓN
      menuItem("🏠 Inicio", tabName = "inicio", icon = icon("home")),
      menuItem("📚 Marco Teórico", tabName = "teoria", icon = icon("book")),
      menuItem("🎯 Objetivos y Variables", tabName = "objetivos", icon = icon("bullseye")),
      
      # SECCIÓN 2: RESULTADOS TÉCNICOS
      menuItem("⏱️ Tiempos de Entrenamiento", tabName = "tiempos", icon = icon("clock")),
      menuItem("📈 Regresión Lineal", tabName = "regresion", icon = icon("chart-line")),
      menuItem("🌳 Árbol de Decisión", tabName = "arbol", icon = icon("tree")),
      menuItem("🧠 Red Neuronal", tabName = "red", icon = icon("brain")),
      menuItem("📊 Comparación de Modelos", tabName = "comparacion", icon = icon("chart-bar")),
      menuItem("✅ Validación en Test", tabName = "validacion", icon = icon("check-circle")),
      menuItem("📉 Análisis de Residuales", tabName = "graficos", icon = icon("chart-area")),
      
      # SECCIÓN 3: CIERRE
      menuItem("🏆 Conclusiones", tabName = "conclusiones", icon = icon("flag-checkered")),
      menuItem("📖 Referencias", tabName = "referencias", icon = icon("bookmark"))
    ),
    
    # Navegación rápida
    div(
      style = "padding: 15px; position: absolute; bottom: 10px; width: 100%;",
      actionButton("btn_prev", "← Anterior", class = "btn-sm btn-default", style = "width: 48%;"),
      actionButton("btn_next", "Siguiente →", class = "btn-sm btn-primary", style = "width: 48%; float: right;")
    )
  ),
  
  dashboardBody(
    # Estilos CSS personalizados - OPTIMIZADO PARA PRESENTACIONES
    tags$head(
      tags$style(HTML("
        /* ========== FUENTES BASE GRANDES PARA PRESENTACIÓN ========== */
        body {
          font-size: 18px !important;
          line-height: 1.6 !important;
        }
        
        .box-body {
          font-size: 20px !important;
          line-height: 1.7 !important;
        }
        
        .box-body p {
          font-size: 20px !important;
          margin-bottom: 12px !important;
        }
        
        .box-body li {
          font-size: 19px !important;
          margin-bottom: 8px !important;
        }
        
        .box-title {
          font-size: 24px !important;
          font-weight: 600 !important;
        }
        
        /* ========== FONDO GENERAL ========== */
        .content-wrapper { 
          background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
          min-height: 100vh;
        }
        
        /* ========== CAJAS PRINCIPALES ========== */
        .box {
          background: rgba(255, 255, 255, 0.98);
          border-radius: 15px;
          box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
          border: none;
          margin-bottom: 25px;
        }
        
        .box.box-primary { border-top: 5px solid #9c27b0; }
        .box.box-success { border-top: 5px solid #4caf50; }
        .box.box-warning { border-top: 5px solid #ff9800; }
        .box.box-info { border-top: 5px solid #2196f3; }
        
        /* ========== TÍTULOS DE SECCIÓN ========== */
        .section-title {
          color: #fff;
          font-size: 32px !important;
          font-weight: 700;
          margin-bottom: 25px;
          padding-bottom: 15px;
          border-bottom: 3px solid rgba(255,255,255,0.3);
        }
        
        h3.section-title, h2.section-title {
          font-size: 32px !important;
        }
        
        /* ========== INFO CARDS (gradientes) ========== */
        .info-card {
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          color: white;
          padding: 30px;
          border-radius: 15px;
          margin-bottom: 20px;
          box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
          min-height: 160px;
        }
        
        .info-card h3 {
          margin: 0 0 15px 0;
          font-size: 26px !important;
          font-weight: 600;
        }
        
        .info-card p {
          margin: 5px 0;
          font-size: 22px !important;
          opacity: 0.95;
        }
        
        /* ========== ALGORITMO CARDS ========== */
        .algo-card {
          background: white;
          padding: 25px 30px;
          border-radius: 12px;
          margin-bottom: 20px;
          border-left: 6px solid #9c27b0;
          box-shadow: 0 4px 15px rgba(0,0,0,0.1);
          min-height: 140px;
        }
        
        .algo-card h4 {
          color: #9c27b0;
          margin: 0 0 12px 0;
          font-size: 24px !important;
          font-weight: 600;
        }
        
        .algo-card p {
          color: #444;
          margin: 0;
          font-size: 18px !important;
          line-height: 1.5;
        }
        
        /* ========== HERO SECTION ========== */
        .hero-section {
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          color: white;
          padding: 50px 40px;
          border-radius: 20px;
          text-align: center;
          margin-bottom: 30px;
          box-shadow: 0 10px 40px rgba(102, 126, 234, 0.3);
        }
        
        .hero-section h1 {
          font-size: 3em !important;
          font-weight: 700;
          margin-bottom: 15px;
        }
        
        .hero-section h3 {
          font-size: 1.6em !important;
          opacity: 0.9;
          font-weight: 400;
        }
        
        .hero-section h4 {
          font-size: 1.4em !important;
        }
        
        /* ========== VALUE BOXES ========== */
        .small-box {
          border-radius: 15px;
          box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .small-box h3 {
          font-size: 38px !important;
        }
        
        .small-box p {
          font-size: 18px !important;
        }
        
        /* ========== CONCLUSIONES ========== */
        .conclusion-box {
          background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
          color: white;
          padding: 30px;
          border-radius: 15px;
          margin-bottom: 20px;
          min-height: 180px;
        }
        
        .conclusion-box h4 {
          margin: 0 0 15px 0;
          font-size: 24px !important;
          font-weight: 600;
        }
        
        .conclusion-box p, .conclusion-box li {
          font-size: 20px !important;
          margin-bottom: 8px;
        }
        
        /* ========== MEJORAS ITEMS ========== */
        .mejora-item {
          background: #fff3e0;
          padding: 18px 22px;
          border-radius: 10px;
          margin-bottom: 15px;
          border-left: 5px solid #ff9800;
        }
        
        .mejora-item p {
          font-size: 18px !important;
          margin: 0;
          color: #333;
        }
        
        /* ========== REFERENCIAS ========== */
        .ref-item {
          padding: 15px 20px;
          background: #f8f9fa;
          border-radius: 10px;
          margin-bottom: 12px;
          font-size: 16px !important;
          border-left: 4px solid #9c27b0;
        }
        
        .ref-item:hover {
          background: #f0f0f0;
        }
        
        /* ========== SIDEBAR ========== */
        .skin-purple .main-sidebar {
          background-color: #1a1a2e;
        }
        
        .skin-purple .sidebar-menu > li.active > a {
          border-left-color: #9c27b0;
          background: rgba(156, 39, 176, 0.2);
        }
        
        .sidebar-menu > li > a {
          font-size: 15px !important;
        }
        
        /* ========== TABLAS ========== */
        .dataTables_wrapper {
          padding: 15px;
        }
        
        .dataTable {
          font-size: 16px !important;
        }
        
        .dataTable th {
          font-size: 17px !important;
          font-weight: 600 !important;
        }
        
        /* ========== HEADER ========== */
        .main-header .logo {
          font-weight: bold;
          font-size: 18px !important;
        }
        
        /* ========== LISTAS MEJORADAS ========== */
        .box-body ol, .box-body ul {
          padding-left: 25px;
        }
        
        .box-body ol li, .box-body ul li {
          padding: 5px 0;
        }
        
        /* ========== SUBTÍTULOS EN CONTENIDO ========== */
        .box-body h4 {
          font-size: 22px !important;
          font-weight: 600;
          margin-top: 15px;
          margin-bottom: 12px;
        }
        
        .box-body h5 {
          font-size: 20px !important;
          font-weight: 600;
          margin-bottom: 10px;
        }
        
        /* ========== REGLA APLICADA BOX ========== */
        .info-card.regla-box {
          min-height: auto;
          padding: 25px;
        }
        
        .info-card.regla-box p {
          font-size: 20px !important;
        }
      "))
    ),
    
    tabItems(
      
      # ========================================================================
      # TAB: INICIO (Portada)
      # ========================================================================
      tabItem(
        tabName = "inicio",
        
        div(
          class = "hero-section",
          h1(icon("car"), " Predicción de Congestión Vehicular"),
          h3("Análisis de Machine Learning en Santiago de Chile"),
          hr(style = "border-color: rgba(255,255,255,0.3); width: 50%;"),
          h4("Minería de Datos - 2025"),
          p(style = "font-size: 16px; margin-top: 20px;",
            icon("graduation-cap"), " Proyecto Universitario")
        ),
        
        fluidRow(
          column(6,
            div(class = "info-card",
              h3(icon("user"), " Autor"),
              p("Javier Farías")
            )
          ),
          column(6,
            div(class = "info-card",
              h3(icon("university"), " Institución"),
              p("Universidad Andrés Bello"),
              p("Ingeniería Civil Informática")
            )
          )
        ),
        
        fluidRow(
          column(4,
            valueBoxOutput("vb_observaciones", width = 12)
          ),
          column(4,
            valueBoxOutput("vb_algoritmos", width = 12)
          ),
          column(4,
            valueBoxOutput("vb_ganador", width = 12)
          )
        ),
        
        fluidRow(
          box(
            title = "📋 Resumen del Proyecto",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            p("Este proyecto analiza la ", strong("congestión vehicular en Santiago"), 
              " utilizando técnicas de ", strong("Machine Learning supervisado"), "."),
            p("Se compararon ", strong("5 algoritmos de regresión"), 
              " para predecir la duración de episodios de congestión basándose en ",
              "características geográficas, temporales y de infraestructura vial."),
            p("El modelo ganador (", strong("K-NN"), ") logra predecir la duración con un ",
              strong("error promedio de ~31 minutos"), ", útil para planificación urbana.")
          )
        )
      ),
      
      # ========================================================================
      # TAB: MARCO TEÓRICO
      # ========================================================================
      tabItem(
        tabName = "teoria",
        
        h2(class = "section-title", icon("book"), " Marco Teórico"),
        
        fluidRow(
          box(
            title = "¿Qué es el Aprendizaje Supervisado?",
            status = "info",
            solidHeader = TRUE,
            width = 12,
            fluidRow(
              column(12,
                p(style = "font-size: 22px; margin-bottom: 20px;",
                  "El ", strong("aprendizaje supervisado"), " entrena modelos con ", 
                  strong("datos etiquetados"), " (entrada → salida conocida) para predecir en datos nuevos.")
              )
            ),
            fluidRow(
              column(6,
                div(class = "info-card", style = "background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); text-align: center;",
                  h3(icon("tags"), " Clasificación"),
                  p(style = "font-size: 24px; font-weight: 500;", "Predice CATEGORÍAS"),
                  p("Ej: spam/no spam, enfermo/sano")
                )
              ),
              column(6,
                div(class = "info-card", style = "background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%); text-align: center;",
                  h3(icon("chart-line"), " Regresión"),
                  p(style = "font-size: 24px; font-weight: 500;", "Predice NÚMEROS"),
                  p("Ej: precio, temperatura, duración")
                )
              )
            )
          )
        ),
        
        h3(style = "color: #fff; font-size: 28px; margin: 30px 0 20px 0;", icon("cogs"), " Los 5 Algoritmos"),
        
        fluidRow(
          column(4,
            div(class = "algo-card",
              h4("1. Regresión Lineal"),
              p("Baseline. Relación lineal. Muy interpretable.")
            ),
            div(class = "algo-card",
              h4("2. Árbol de Decisión"),
              p("Reglas si-entonces. Captura no linealidades.")
            )
          ),
          column(4,
            div(class = "algo-card",
              h4("3. Red Neuronal"),
              p("Capas de neuronas. Patrones complejos.")
            ),
            div(class = "algo-card",
              h4("4. SVM-ε"),
              p("Kernel RBF. Robusto ante outliers.")
            )
          ),
          column(4,
            div(class = "algo-card",
              h4("5. K-NN"),
              p("Vecinos cercanos. Patrones locales.")
            ),
            div(class = "algo-card", style = "border-left-color: #4caf50; background: #e8f5e9;",
              h4(style = "color: #4caf50;", icon("star"), " Ganador: K-NN"),
              p("Mejor para tráfico urbano heterogéneo.")
            )
          )
        )
      ),
      
      # ========================================================================
      # TAB: OBJETIVOS Y VARIABLES
      # ========================================================================
      tabItem(
        tabName = "objetivos",
        
        h2(class = "section-title", icon("bullseye"), " Objetivos y Variables"),
        
        fluidRow(
          column(12,
            div(class = "info-card", style = "background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); text-align: center; padding: 35px;",
              h3(style = "font-size: 20px; margin-bottom: 10px; opacity: 0.9;", "🎯 OBJETIVO GENERAL"),
              p(style = "font-size: 28px; font-weight: 500; margin: 0;", 
                "Predecir la duración de congestión vehicular en Santiago")
            )
          )
        ),
        
        br(),
        
        fluidRow(
          column(6,
            box(
              title = "📊 Variable Objetivo",
              status = "success",
              solidHeader = TRUE,
              width = 12,
              div(style = "text-align: center; padding: 15px;",
                h3(style = "color: #4caf50; font-size: 32px; margin: 10px 0;", "Duration_hrs"),
                p(style = "font-size: 20px;", "Duración en horas"),
                hr(),
                fluidRow(
                  column(4, div(style = "text-align: center;",
                    h4(style = "color: #666; margin: 0;", "Tipo"),
                    p(style = "font-size: 18px; font-weight: 500;", "Numérica")
                  )),
                  column(4, div(style = "text-align: center;",
                    h4(style = "color: #666; margin: 0;", "Valores"),
                    p(style = "font-size: 18px; font-weight: 500;", "118 únicos")
                  )),
                  column(4, div(style = "text-align: center;",
                    h4(style = "color: #666; margin: 0;", "Decisión"),
                    p(style = "font-size: 18px; font-weight: 500; color: #9c27b0;", "REGRESIÓN")
                  ))
                )
              )
            )
          ),
          column(6,
            box(
              title = "📋 Features (24 variables)",
              status = "info",
              solidHeader = TRUE,
              width = 12,
              div(style = "padding: 10px;",
                p(style = "font-size: 20px;", icon("map-marker-alt", style = "color: #2196f3;"), 
                  strong(" Geográficas:"), " Commune, Lat, Long"),
                p(style = "font-size: 20px;", icon("road", style = "color: #ff9800;"), 
                  strong(" Infraestructura:"), " Length_km"),
                p(style = "font-size: 20px;", icon("tachometer-alt", style = "color: #4caf50;"), 
                  strong(" Tráfico:"), " Speed_kmh"),
                hr(),
                p(style = "font-size: 18px; color: #666; text-align: center;",
                  "Variables procesadas con One-Hot Encoding")
              )
            )
          )
        ),
        
        fluidRow(
          box(
            title = "⚖️ ¿Por qué REGRESIÓN?",
            status = "warning",
            solidHeader = TRUE,
            width = 12,
            fluidRow(
              column(8,
                div(style = "padding: 10px;",
                  p(style = "font-size: 22px;", icon("check", style = "color: #4caf50;"), 
                    " Duration_hrs es ", strong("numérica continua")),
                  p(style = "font-size: 22px;", icon("check", style = "color: #4caf50;"), 
                    " Con ", strong("118 valores únicos"), ", clasificación sería impráctico"),
                  p(style = "font-size: 22px;", icon("check", style = "color: #4caf50;"), 
                    " Predecir ", strong("'2.5 horas'"), " es más útil que 'congestión media'")
                )
              ),
              column(4,
                div(class = "info-card", style = "background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); text-align: center;",
                  h3(icon("lightbulb"), " Regla"),
                  p(style = "font-size: 20px;", ">20 valores únicos"),
                  p(style = "font-size: 20px;", "= REGRESIÓN")
                )
              )
            )
          )
        )
      ),
      
      # ========================================================================
      # TAB: TIEMPOS DE ENTRENAMIENTO
      # ========================================================================
      tabItem(
        tabName = "tiempos",
        
        h2(class = "section-title", icon("clock"), " Tiempos de Entrenamiento"),
        
        fluidRow(
          valueBoxOutput("tiempo_total", width = 4),
          valueBoxOutput("modelo_rapido", width = 4),
          valueBoxOutput("modelo_lento", width = 4)
        ),
        
        fluidRow(
          box(
            title = "📊 Tiempos por Algoritmo (Validación Cruzada 3-fold)",
            status = "warning",
            solidHeader = TRUE,
            width = 8,
            plotlyOutput("plot_tiempos", height = "400px")
          ),
          box(
            title = "💻 Especificaciones",
            status = "info",
            solidHeader = TRUE,
            width = 4,
            verbatimTextOutput("system_info"),
            hr(),
            h5(icon("database"), " Dataset:"),
            p("• 10,000 observaciones"),
            p("• 24 features"),
            p("• 3-fold Cross-Validation")
          )
        ),
        
        fluidRow(
          box(
            title = "📋 Tabla Detallada de Tiempos",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            DTOutput("tabla_tiempos")
          )
        )
      ),
      
      # ========================================================================
      # TAB: REGRESIÓN LINEAL
      # ========================================================================
      tabItem(
        tabName = "regresion",
        
        h2(class = "section-title", icon("chart-line"), " Modelo de Regresión Lineal"),
        
        fluidRow(
          box(
            title = "📊 Tabla de Coeficientes",
            status = "success",
            solidHeader = TRUE,
            width = 12,
            p("Los coeficientes representan el ", strong("impacto de cada variable"), " en la duración de congestión (horas)."),
            p(icon("arrow-up", style = "color: #d32f2f;"), " Coeficientes positivos → aumentan duración | ",
              icon("arrow-down", style = "color: #4caf50;"), " Coeficientes negativos → disminuyen duración"),
            hr(),
            DTOutput("tabla_coeficientes")
          )
        )
      ),
      
      # ========================================================================
      # TAB: ÁRBOL DE DECISIÓN
      # ========================================================================
      tabItem(
        tabName = "arbol",
        
        h2(class = "section-title", icon("tree"), " Árbol de Decisión"),
        
        fluidRow(
          box(
            title = "🌳 Visualización del Modelo",
            status = "success",
            solidHeader = TRUE,
            width = 12,
            plotOutput("plot_arbol", height = "600px"),
            hr(),
            fluidRow(
              column(6,
                h5(icon("info-circle"), " Interpretación:"),
                p("• Cada nodo representa una ", strong("decisión basada en una variable")),
                p("• Los colores indican la ", strong("magnitud de predicción")),
                p("• Las ramas dividen los datos según umbrales")
              ),
              column(6,
                h5(icon("cog"), " Parámetros:"),
                p("• ", strong("Método:"), " rpart (Recursive Partitioning)"),
                p("• ", strong("cp:"), " Complexity parameter optimizado por CV"),
                p("• ", strong("Grid:"), " cp ∈ {0.01, 0.05}")
              )
            )
          )
        )
      ),
      
      # ========================================================================
      # TAB: RED NEURONAL
      # ========================================================================
      tabItem(
        tabName = "red",
        
        h2(class = "section-title", icon("brain"), " Red Neuronal"),
        
        fluidRow(
          box(
            title = "🧠 Arquitectura de la Red",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            plotOutput("plot_red_neuronal", height = "600px"),
            hr(),
            fluidRow(
              column(4,
                div(class = "info-card", style = "background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);",
                  h4(icon("sign-in-alt"), " Capa de Entrada"),
                  p("24 neuronas"),
                  p(style = "font-size: 12px;", "Una por cada feature del dataset")
                )
              ),
              column(4,
                div(class = "info-card", style = "background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);",
                  h4(icon("cogs"), " Capa Oculta"),
                  p("3-5 neuronas"),
                  p(style = "font-size: 12px;", "Optimizado por validación cruzada")
                )
              ),
              column(4,
                div(class = "info-card", style = "background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);",
                  h4(icon("sign-out-alt"), " Capa de Salida"),
                  p("1 neurona"),
                  p(style = "font-size: 12px;", "Predicción: Duration_hrs")
                )
              )
            ),
            p(style = "margin-top: 15px;", 
              icon("cog"), " ", strong("Configuración:"), " nnet con linout=TRUE, decay=0.1 para regularización, maxit=100")
          )
        )
      ),
      
      # ========================================================================
      # TAB: COMPARACIÓN DE MODELOS
      # ========================================================================
      tabItem(
        tabName = "comparacion",
        
        h2(class = "section-title", icon("chart-bar"), " Comparación de Modelos"),
        
        fluidRow(
          box(
            title = "🏆 Ranking de Modelos por RMSE (menor es mejor)",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            plotlyOutput("plot_comparacion", height = "450px")
          )
        ),
        
        fluidRow(
          box(
            title = "📊 Métricas Detalladas con Hiperparámetros Óptimos",
            status = "info",
            solidHeader = TRUE,
            width = 12,
            DTOutput("tabla_metricas"),
            hr(),
            fluidRow(
              column(3, 
                h5(icon("calculator"), " RMSE"),
                p(style = "font-size: 12px; color: #666;", "Root Mean Square Error. Penaliza errores grandes.")
              ),
              column(3,
                h5(icon("ruler"), " MAE"),
                p(style = "font-size: 12px; color: #666;", "Error Absoluto Medio. Más interpretable.")
              ),
              column(3,
                h5(icon("percent"), " R²"),
                p(style = "font-size: 12px; color: #666;", "Varianza explicada por el modelo.")
              ),
              column(3,
                h5(icon("percentage"), " MAPE"),
                p(style = "font-size: 12px; color: #666;", "Error Porcentual Absoluto Medio.")
              )
            )
          )
        )
      ),
      
      # ========================================================================
      # TAB: VALIDACIÓN EN TEST
      # ========================================================================
      tabItem(
        tabName = "validacion",
        
        h2(class = "section-title", icon("check-circle"), " Validación en Datos de Prueba"),
        
        fluidRow(
          valueBoxOutput("ganador_rmse", width = 3),
          valueBoxOutput("ganador_mae", width = 3),
          valueBoxOutput("ganador_r2", width = 3),
          valueBoxOutput("ganador_mape", width = 3)
        ),
        
        fluidRow(
          box(
            title = "📋 Resultados en Test Set (20% de los datos)",
            status = "success",
            solidHeader = TRUE,
            width = 12,
            p(icon("info-circle"), " Estas métricas fueron calculadas en el ", 
              strong("conjunto de prueba"), ", datos ", strong("nunca vistos"), " durante el entrenamiento."),
            hr(),
            DTOutput("tabla_validacion_test")
          )
        ),
        
        fluidRow(
          box(
            title = "🏆 Interpretación del Modelo Ganador: K-NN",
            status = "primary",
            solidHeader = TRUE,
            width = 12,
            fluidRow(
              column(6,
                h4(icon("chart-line"), " Métricas Clave:"),
                tags$ul(
                  tags$li(strong("RMSE = 0.935 horas:"), " Error cuadrático medio de ~56 minutos"),
                  tags$li(strong("MAE = 0.51 horas:"), " Error promedio de ", strong("~31 minutos")),
                  tags$li(strong("R² = 20.6%:"), " Varianza explicada (razonable para tráfico urbano)")
                )
              ),
              column(6,
                h4(icon("question-circle"), " ¿Por qué K-NN ganó?"),
                p("K-NN capturó mejor las ", strong("relaciones no lineales locales"), " entre features geoespaciales y temporales."),
                p("Al basarse en vecinos cercanos, el modelo identifica ", strong("patrones específicos de zonas/horarios"), 
                  " sin asumir relaciones globales, ideal para tráfico urbano heterogéneo.")
              )
            )
          )
        )
      ),
      
      # ========================================================================
      # TAB: ANÁLISIS DE RESIDUALES
      # ========================================================================
      tabItem(
        tabName = "graficos",
        
        h2(class = "section-title", icon("chart-area"), " Análisis de Residuales e Importancia"),
        
        fluidRow(
          box(
            title = "📉 Residuales vs Predicción",
            status = "warning",
            solidHeader = TRUE,
            width = 6,
            plotOutput("plot_residuales", height = "450px"),
            hr(),
            p(icon("info-circle"), " Puntos cercanos a la diagonal = buenas predicciones. ",
              "La dispersión indica el error del modelo.")
          ),
          box(
            title = "📊 Importancia de Variables",
            status = "info",
            solidHeader = TRUE,
            width = 6,
            plotOutput("plot_importancia", height = "450px"),
            hr(),
            h5(icon("trophy"), " Top 3 Features:"),
            tags$ol(
              tags$li(strong("Length_km:"), " Longitud del trayecto (mayor impacto)"),
              tags$li(strong("Commune_Santiago:"), " Zona céntrica con patrones distintivos"),
              tags$li(strong("Longitud:"), " Eje este-oeste de la ciudad")
            )
          )
        )
      ),
      
      # ========================================================================
      # TAB: CONCLUSIONES
      # ========================================================================
      tabItem(
        tabName = "conclusiones",
        
        h2(class = "section-title", icon("flag-checkered"), " Conclusiones"),
        
        fluidRow(
          column(6,
            div(class = "conclusion-box", style = "text-align: center; min-height: 200px;",
              h3(style = "font-size: 26px; margin-bottom: 20px;", icon("star"), " Modelo Ganador"),
              h2(style = "font-size: 48px; margin: 15px 0;", "K-NN"),
              p(style = "font-size: 24px;", "Error: ", strong("~31 minutos"))
            )
          ),
          column(6,
            div(class = "conclusion-box", style = "background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 200px;",
              h3(style = "font-size: 26px;", icon("lightbulb"), " Hallazgo Principal"),
              p(style = "font-size: 22px; margin-top: 20px;", 
                "El tráfico de Santiago tiene ", strong("patrones locales"), " que K-NN captura mejor que modelos lineales.")
            )
          )
        ),
        
        fluidRow(
          column(6,
            div(class = "conclusion-box", style = "background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);",
              h3(style = "font-size: 24px;", icon("map-marker-alt"), " Top Variables"),
              p(style = "font-size: 22px;", "1. Length_km (longitud)"),
              p(style = "font-size: 22px;", "2. Commune_Santiago"),
              p(style = "font-size: 22px;", "3. Coordenada Longitud")
            )
          ),
          column(6,
            div(class = "conclusion-box", style = "background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);",
              h3(style = "font-size: 24px;", icon("building"), " Aplicaciones"),
              p(style = "font-size: 22px;", "• Planificación urbana"),
              p(style = "font-size: 22px;", "• Info ciudadana en tiempo real"),
              p(style = "font-size: 22px;", "• Optimización de rutas")
            )
          )
        ),
        
        fluidRow(
          box(
            title = "🔧 Limitaciones y Mejoras Futuras",
            status = "warning",
            solidHeader = TRUE,
            width = 12,
            fluidRow(
              column(6,
                h4(style = "color: #ff5722;", icon("exclamation-triangle"), " Limitaciones"),
                p(style = "font-size: 20px;", "• R² = 20.6% (varianza no explicada: 79%)"),
                p(style = "font-size: 20px;", "• Dataset reducido (10k de 76k)"),
                p(style = "font-size: 20px;", "• Variables eliminadas: Street, Peak_Time")
              ),
              column(6,
                h4(style = "color: #4caf50;", icon("arrow-up"), " Mejoras Propuestas"),
                p(style = "font-size: 20px;", "• Incorporar clima y eventos"),
                p(style = "font-size: 20px;", "• Usar dataset completo"),
                p(style = "font-size: 20px;", "• Probar Random Forest, XGBoost")
              )
            )
          )
        )
      ),
      
      # ========================================================================
      # TAB: REFERENCIAS
      # ========================================================================
      tabItem(
        tabName = "referencias",
        
        h2(class = "section-title", icon("bookmark"), " Referencias"),
        
        fluidRow(
          box(
            title = "📚 Bibliografía Principal",
            status = "info",
            solidHeader = TRUE,
            width = 6,
            div(class = "ref-item",
              p(strong("[1]"), " James et al. (2021). ", em("An Introduction to Statistical Learning"), ". Springer.")
            ),
            div(class = "ref-item",
              p(strong("[2]"), " Kuhn & Johnson (2019). ", em("Feature Engineering and Selection"), ". CRC.")
            ),
            div(class = "ref-item",
              p(strong("[3]"), " Hastie et al. (2009). ", em("Elements of Statistical Learning"), ". Springer.")
            )
          ),
          box(
            title = "📊 Fuentes de Datos",
            status = "success",
            solidHeader = TRUE,
            width = 6,
            div(class = "ref-item",
              p(strong("[4]"), " MTT Chile (2024). ", em("Informe Congestión RM"), ".")
            ),
            div(class = "ref-item",
              p(strong("[5]"), " SECTRA (2023). ", em("Encuesta Origen Destino Santiago"), ".")
            ),
            div(class = "ref-item",
              p(strong("[6]"), " Kuhn (2008). ", em("caret Package"), ". J. Statistical Software.")
            )
          )
        ),
        
        fluidRow(
          column(12,
            div(class = "info-card", style = "background: linear-gradient(135deg, #333 0%, #1a1a2e 100%); text-align: center;",
              h3(icon("github"), " Repositorio"),
              p(style = "font-size: 24px;",
                a("github.com/Zapalloman/solemne-2-miner-a", 
                  href = "https://github.com/Zapalloman/solemne-2-miner-a", 
                  target = "_blank",
                  style = "color: #4facfe;"))
            )
          )
        ),
        
        fluidRow(
          column(12,
            div(style = "text-align: center; padding: 30px; color: #fff;",
              h3("¡Gracias por su atención!"),
              p(style = "font-size: 20px; opacity: 0.8;", "Javier Farías"),
              p(style = "font-size: 18px; opacity: 0.6;", "Universidad Andrés Bello - 2025")
            )
          )
        )
      )
      
    ) # Fin tabItems
  ) # Fin dashboardBody
) # Fin dashboardPage


# ============================================================================
# SERVIDOR
# ============================================================================

server <- function(input, output, session) {
  
  # --------------------------------------------------------------------------
  # CARGAR DATOS
  # --------------------------------------------------------------------------
  
  resultados <- reactive({
    req(file.exists("results.csv"))
    read.csv("results.csv")
  })
  
  tiempos <- reactive({
    req(file.exists("training_times.csv"))
    read.csv("training_times.csv")
  })
  
  modelos_data <- reactive({
    req(file.exists("models_and_preprocessing.rds"))
    readRDS("models_and_preprocessing.rds")
  })
  
  # --------------------------------------------------------------------------
  # NAVEGACIÓN CON BOTONES
  # --------------------------------------------------------------------------
  
  tabs_order <- c("inicio", "teoria", "objetivos", "tiempos", "regresion", 
                  "arbol", "red", "comparacion", "validacion", "graficos", 
                  "conclusiones", "referencias")
  
  observeEvent(input$btn_next, {
    current <- which(tabs_order == input$tabs)
    if (current < length(tabs_order)) {
      updateTabItems(session, "tabs", tabs_order[current + 1])
    }
  })
  
  observeEvent(input$btn_prev, {
    current <- which(tabs_order == input$tabs)
    if (current > 1) {
      updateTabItems(session, "tabs", tabs_order[current - 1])
    }
  })
  
  # --------------------------------------------------------------------------
  # TAB: INICIO - Value Boxes
  # --------------------------------------------------------------------------
  
  output$vb_observaciones <- renderValueBox({
    valueBox(
      "10,000",
      "Observaciones Analizadas",
      icon = icon("database"),
      color = "purple"
    )
  })
  
  output$vb_algoritmos <- renderValueBox({
    valueBox(
      "5",
      "Algoritmos Comparados",
      icon = icon("cogs"),
      color = "blue"
    )
  })
  
  output$vb_ganador <- renderValueBox({
    valueBox(
      "K-NN",
      "Modelo Ganador",
      icon = icon("trophy"),
      color = "green"
    )
  })
  
  # --------------------------------------------------------------------------
  # TAB: TIEMPOS DE ENTRENAMIENTO
  # --------------------------------------------------------------------------
  
  output$tiempo_total <- renderValueBox({
    tiempos_df <- tiempos()
    total <- sum(tiempos_df$Training_Time_Seconds)
    valueBox(
      paste0(round(total, 2), " seg"),
      "Tiempo Total",
      icon = icon("clock"),
      color = "blue"
    )
  })
  
  output$modelo_rapido <- renderValueBox({
    tiempos_df <- tiempos()
    min_idx <- which.min(tiempos_df$Training_Time_Seconds)
    valueBox(
      tiempos_df$Model[min_idx],
      paste0("Más Rápido (", round(tiempos_df$Training_Time_Seconds[min_idx], 2), "s)"),
      icon = icon("bolt"),
      color = "green"
    )
  })
  
  output$modelo_lento <- renderValueBox({
    tiempos_df <- tiempos()
    max_idx <- which.max(tiempos_df$Training_Time_Seconds)
    valueBox(
      tiempos_df$Model[max_idx],
      paste0("Más Lento (", round(tiempos_df$Training_Time_Seconds[max_idx], 2), "s)"),
      icon = icon("hourglass-half"),
      color = "red"
    )
  })
  
  output$plot_tiempos <- renderPlotly({
    df <- tiempos()
    
    colors <- c('#667eea', '#764ba2', '#f093fb', '#f5576c', '#11998e')
    
    plot_ly(df, x = ~reorder(Model, -Training_Time_Seconds), y = ~Training_Time_Seconds, 
            type = 'bar', marker = list(color = colors)) %>%
      layout(
        title = "",
        xaxis = list(title = "Modelo"),
        yaxis = list(title = "Tiempo (segundos)"),
        hovermode = "closest"
      )
  })
  
  output$tabla_tiempos <- renderDT({
    datatable(
      tiempos(),
      options = list(pageLength = 10, dom = 't'),
      rownames = FALSE,
      colnames = c("Modelo", "Tiempo (segundos)")
    ) %>%
      formatRound(columns = 'Training_Time_Seconds', digits = 3)
  })
  
  output$system_info <- renderText({
    paste(
      "Sistema:", Sys.info()["sysname"],
      "\nArquitectura:", Sys.info()["machine"],
      "\nR:", R.version.string
    )
  })
  
  # --------------------------------------------------------------------------
  # TAB: REGRESIÓN LINEAL
  # --------------------------------------------------------------------------
  
  output$tabla_coeficientes <- renderDT({
    modelo_data <- modelos_data()
    
    if ("Linear_Regression" %in% names(modelo_data$models)) {
      modelo_lm <- modelo_data$models[["Linear_Regression"]]
      coef_df <- data.frame(
        Variable = names(coef(modelo_lm$finalModel)),
        Coeficiente = as.numeric(coef(modelo_lm$finalModel)),
        stringsAsFactors = FALSE
      )
      
      coef_df$Impacto <- ifelse(coef_df$Coeficiente > 0, "↑ Aumenta", "↓ Disminuye")
      coef_df <- coef_df[order(abs(coef_df$Coeficiente), decreasing = TRUE), ]
      
      datatable(
        coef_df,
        options = list(pageLength = 15, dom = 'ftp'),
        rownames = FALSE
      ) %>%
        formatRound(columns = 'Coeficiente', digits = 6) %>%
        formatStyle('Impacto',
          backgroundColor = styleEqual(c('↑ Aumenta', '↓ Disminuye'), c('#ffebee', '#e8f5e9'))
        )
    } else {
      datatable(data.frame(Mensaje = "Modelo no disponible"))
    }
  })
  
  # --------------------------------------------------------------------------
  # TAB: ÁRBOL DE DECISIÓN
  # --------------------------------------------------------------------------
  
  output$plot_arbol <- renderPlot({
    if (file.exists("arbol_decision.png")) {
      img <- png::readPNG("arbol_decision.png")
      grid::grid.raster(img)
    } else {
      plot.new()
      text(0.5, 0.5, "Gráfico no disponible.\nEjecute analisis_completo.R primero.", cex = 1.5)
    }
  })
  
  # --------------------------------------------------------------------------
  # TAB: RED NEURONAL
  # --------------------------------------------------------------------------
  
  output$plot_red_neuronal <- renderPlot({
    if (file.exists("red_neuronal.png")) {
      img <- png::readPNG("red_neuronal.png")
      grid::grid.raster(img)
    } else {
      plot.new()
      text(0.5, 0.5, "Gráfico no disponible.\nEjecute analisis_completo.R primero.", cex = 1.5)
    }
  })
  
  # --------------------------------------------------------------------------
  # TAB: COMPARACIÓN DE MODELOS
  # --------------------------------------------------------------------------
  
  output$plot_comparacion <- renderPlotly({
    df <- resultados()
    
    colors <- ifelse(df$Model == "KNN", '#4caf50', '#9c27b0')
    
    plot_ly(df, x = ~reorder(Model, RMSE), y = ~RMSE, type = 'bar', 
            marker = list(color = colors)) %>%
      layout(
        title = "",
        xaxis = list(title = "Modelo"),
        yaxis = list(title = "RMSE (horas)"),
        hovermode = "closest",
        annotations = list(
          list(
            x = "KNN", y = df$RMSE[df$Model == "KNN"] + 0.02,
            text = "🏆 Ganador", showarrow = FALSE,
            font = list(size = 14, color = "#4caf50")
          )
        )
      )
  })
  
  output$tabla_metricas <- renderDT({
    df <- resultados()
    
    df$Hiperparametros <- c(
      "N/A (baseline)",
      "cp ∈ {0.01, 0.05}",
      "size ∈ {3, 5}, decay = 0.1",
      "σ = 0.05, C ∈ {1, 2}",
      "k ∈ {5, 7}"
    )
    
    datatable(
      df,
      options = list(pageLength = 10, dom = 't', ordering = TRUE),
      rownames = FALSE,
      colnames = c("Modelo", "RMSE", "MAE", "R²", "MAPE (%)", "Hiperparámetros")
    ) %>%
      formatRound(columns = c('RMSE', 'MAE', 'R2', 'MAPE'), digits = 4) %>%
      formatStyle('Model',
        target = 'row',
        backgroundColor = styleEqual(c('KNN'), c('#e8f5e9'))
      )
  })
  
  # --------------------------------------------------------------------------
  # TAB: VALIDACIÓN EN TEST
  # --------------------------------------------------------------------------
  
  output$ganador_rmse <- renderValueBox({
    df <- resultados()
    mejor <- df[which.min(df$RMSE), ]
    valueBox(
      round(mejor$RMSE, 4),
      "RMSE (horas)",
      icon = icon("calculator"),
      color = "green"
    )
  })
  
  output$ganador_mae <- renderValueBox({
    df <- resultados()
    mejor <- df[which.min(df$RMSE), ]
    valueBox(
      paste0(round(mejor$MAE * 60, 0), " min"),
      "MAE (~31 minutos)",
      icon = icon("clock"),
      color = "blue"
    )
  })
  
  output$ganador_r2 <- renderValueBox({
    df <- resultados()
    mejor <- df[which.min(df$RMSE), ]
    valueBox(
      paste0(round(mejor$R2 * 100, 1), "%"),
      "R² (Varianza Explicada)",
      icon = icon("percent"),
      color = "orange"
    )
  })
  
  output$ganador_mape <- renderValueBox({
    df <- resultados()
    mejor <- df[which.min(df$RMSE), ]
    valueBox(
      paste0(round(mejor$MAPE, 1), "%"),
      "MAPE",
      icon = icon("percentage"),
      color = "purple"
    )
  })
  
  output$tabla_validacion_test <- renderDT({
    df <- resultados()
    
    datatable(
      df,
      options = list(pageLength = 10, dom = 't'),
      rownames = FALSE
    ) %>%
      formatRound(columns = c('RMSE', 'MAE', 'R2', 'MAPE'), digits = 4) %>%
      formatStyle('Model',
        target = 'row',
        fontWeight = styleEqual(c('KNN'), c('bold')),
        backgroundColor = styleEqual(c('KNN'), c('#c8e6c9'))
      )
  })
  
  # --------------------------------------------------------------------------
  # TAB: ANÁLISIS DE RESIDUALES
  # --------------------------------------------------------------------------
  
  output$plot_residuales <- renderPlot({
    if (file.exists("roc_residuales.png")) {
      img <- png::readPNG("roc_residuales.png")
      grid::grid.raster(img)
    } else {
      plot.new()
      text(0.5, 0.5, "Gráfico no disponible", cex = 1.5)
    }
  })
  
  output$plot_importancia <- renderPlot({
    if (file.exists("importancia_variables.png")) {
      img <- png::readPNG("importancia_variables.png")
      grid::grid.raster(img)
    } else {
      plot.new()
      text(0.5, 0.5, "Gráfico no disponible", cex = 1.5)
    }
  })
  
}

# ============================================================================
# EJECUTAR APLICACIÓN
# ============================================================================

shinyApp(ui, server)
