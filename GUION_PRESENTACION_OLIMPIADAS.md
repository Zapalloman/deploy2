# GUIÓN DE PRESENTACIÓN - OLIMPIADAS CIENCIA DE DATOS 2025

## Equipo
- **Javier Farías**
- **Uriel Navarrete**

Universidad Andrés Bello - Ingeniería Civil Informática

---

## DISTRIBUCIÓN DEL CONTENIDO

### ⏱️ TIEMPO TOTAL: ~12-15 minutos

---

## 👤 JAVIER FARÍAS (Primera mitad: ~6-7 minutos)

### Pestañas a presentar:

#### 1. 🏠 INICIO (~1 minuto)
- Saludar y presentar al equipo
- Mencionar que ganamos las olimpiadas regionales
- Describir brevemente el proyecto: "Predicción de congestión vehicular en Santiago usando Machine Learning"
- Destacar los 3 KPIs: 10,000 observaciones, 5 algoritmos, K-NN ganador

**Qué decir:**
> "Buenos días. Somos Javier Farías y Uriel Navarrete, estudiantes de Ingeniería Civil Informática de la Universidad Andrés Bello. Hoy presentamos nuestro proyecto ganador de las olimpiadas de ciencia de datos: un análisis de Machine Learning para predecir la duración de congestión vehicular en Santiago."

---

#### 2. 📚 MARCO TEÓRICO (~2 minutos)
- Explicar qué es el aprendizaje supervisado (datos etiquetados)
- Diferencia entre clasificación y regresión
- Describir los 5 algoritmos utilizados:
  1. Regresión Lineal → baseline
  2. Árbol de Decisión → captura no linealidades
  3. Red Neuronal → aproximador universal
  4. SVM-ε → robusto a outliers
  5. K-NN → patrones locales
- Mencionar que K-NN fue el ganador

**Qué decir:**
> "El aprendizaje supervisado entrena modelos con datos etiquetados. Puede ser clasificación para categorías o regresión para valores continuos. Nosotros usamos regresión porque predecimos horas de congestión. Comparamos 5 algoritmos: regresión lineal como baseline, árboles de decisión para capturar no linealidades, redes neuronales, SVM y K-NN. Adelanto que K-NN resultó ganador."

---

#### 3. 🎯 OBJETIVOS Y VARIABLES (~1.5 minutos)
- Objetivo: predecir duración de congestión con precisión
- Variable dependiente: Duration_hrs (118 valores únicos)
- Variables independientes: geográficas, infraestructura, tráfico
- Justificación de REGRESIÓN: variable continua, muchos valores únicos

**Qué decir:**
> "Nuestro objetivo es predecir la duración de congestión. La variable objetivo es Duration_hrs, que tiene 118 valores únicos, por eso elegimos regresión y no clasificación. Usamos 24 features que incluyen longitud del trayecto, comuna, coordenadas y velocidad."

---

#### 4. ⏱️ TIEMPOS DE ENTRENAMIENTO (~1 minuto)
- Mostrar los 3 value boxes (tiempo total, más rápido, más lento)
- Explicar que usamos 3-fold cross-validation
- Mostrar gráfico de tiempos
- Mencionar que SVM fue el más lento (28 segundos)

**Qué decir:**
> "El entrenamiento total tomó aproximadamente 33 segundos. El árbol de decisión fue el más rápido con 0.3 segundos, mientras que SVM fue el más lento con 28 segundos debido a su complejidad computacional."

---

#### 5. 📈 REGRESIÓN LINEAL (~1 minuto)
- Mostrar tabla de coeficientes
- Explicar interpretación: positivo aumenta, negativo disminuye
- Destacar variables con mayor coeficiente

**Qué decir:**
> "La regresión lineal nos permite interpretar los coeficientes. Los valores positivos aumentan la duración de congestión, los negativos la disminuyen. Vemos que la longitud del trayecto tiene gran impacto, como era de esperar."

---

#### 6. 🌳 ÁRBOL DE DECISIÓN (~1 minuto)
- Mostrar visualización del árbol
- Explicar que cada nodo es una decisión
- Mencionar que es fácil de interpretar

**Transición a Uriel:**
> "El árbol de decisión nos muestra cómo el modelo toma decisiones mediante reglas tipo si-entonces. Ahora Uriel continuará con los modelos más avanzados y las conclusiones."

---

## 👤 URIEL NAVARRETE (Segunda mitad: ~6-7 minutos)

### Pestañas a presentar:

#### 7. 🧠 RED NEURONAL (~1 minuto)
- Mostrar arquitectura de la red
- Explicar las 3 capas: entrada (24), oculta (3-5), salida (1)
- Mencionar configuración: nnet con linout=TRUE, decay=0.1

**Qué decir:**
> "Gracias Javier. Continuamos con la red neuronal. Tiene 24 neuronas de entrada correspondientes a nuestras features, una capa oculta de 3 a 5 neuronas optimizada por validación cruzada, y una neurona de salida que produce la predicción de duración."

---

#### 8. 📊 COMPARACIÓN DE MODELOS (~1.5 minutos)
- Mostrar gráfico de barras con RMSE
- Destacar que K-NN tiene menor RMSE (0.9348)
- Mostrar tabla con todas las métricas e hiperparámetros
- Explicar brevemente cada métrica

**Qué decir:**
> "Aquí vemos la comparación de todos los modelos. K-NN obtuvo el mejor RMSE con 0.9348 horas, seguido de cerca por la red neuronal. La tabla muestra los hiperparámetros óptimos encontrados para cada modelo mediante validación cruzada."

---

#### 9. ✅ VALIDACIÓN EN TEST (~1.5 minutos)
- Mostrar los 4 value boxes del modelo ganador
- Explicar que el test set nunca fue visto durante entrenamiento
- Destacar MAE de 31 minutos como métrica interpretable
- Explicar por qué K-NN ganó: patrones locales

**Qué decir:**
> "Estas métricas fueron calculadas en el conjunto de prueba, datos nunca vistos durante el entrenamiento. K-NN logra un error promedio de 31 minutos, que es bastante útil para planificación. Ganó porque captura patrones locales del tráfico santiaguino sin asumir relaciones globales."

---

#### 10. 📉 ANÁLISIS DE RESIDUALES (~1 minuto)
- Mostrar gráfico de residuales
- Explicar que puntos cercanos a diagonal son buenas predicciones
- Mostrar importancia de variables
- Destacar top 3: Length_km, Commune_Santiago, Longitud

**Qué decir:**
> "El gráfico de residuales muestra que las predicciones están bastante centradas. Las variables más importantes son la longitud del trayecto, la comuna de Santiago y la coordenada de longitud, lo que tiene sentido geográficamente."

---

#### 11. 🏆 CONCLUSIONES (~1.5 minutos)
- Modelo ganador: K-NN con error de 31 minutos
- Hallazgo principal: tráfico tiene patrones locales
- Variables clave: Length_km, Commune, Longitud
- Aplicaciones prácticas: planificación urbana, información ciudadana
- Deficiencias: R² bajo (20.6%), dataset reducido
- Mejoras futuras: más variables (clima), dataset completo, ensemble methods

**Qué decir:**
> "En conclusión, K-NN es el modelo ganador con un error promedio de 31 minutos. El tráfico de Santiago tiene patrones locales fuertes que este algoritmo captura bien. Aunque el R² de 20.6% es modesto, es razonable para tráfico urbano que tiene componentes aleatorios. Como mejoras futuras proponemos incorporar datos de clima y eventos."

---

#### 12. 📖 REFERENCIAS (~30 segundos)
- Mencionar las fuentes principales
- Destacar el repositorio de GitHub

**Cierre:**
> "Las referencias incluyen textos clásicos como 'Introduction to Statistical Learning' y datos oficiales del Ministerio de Transportes. Todo el código está disponible en nuestro repositorio de GitHub. ¿Tienen preguntas?"

---

## 📋 RESUMEN DE DISTRIBUCIÓN

| Pestaña | Presentador | Tiempo |
|---------|-------------|--------|
| 🏠 Inicio | Javier | ~1 min |
| 📚 Marco Teórico | Javier | ~2 min |
| 🎯 Objetivos y Variables | Javier | ~1.5 min |
| ⏱️ Tiempos | Javier | ~1 min |
| 📈 Regresión Lineal | Javier | ~1 min |
| 🌳 Árbol de Decisión | Javier | ~1 min |
| 🧠 Red Neuronal | Uriel | ~1 min |
| 📊 Comparación | Uriel | ~1.5 min |
| ✅ Validación | Uriel | ~1.5 min |
| 📉 Residuales | Uriel | ~1 min |
| 🏆 Conclusiones | Uriel | ~1.5 min |
| 📖 Referencias | Uriel | ~0.5 min |

**Total: ~13 minutos**

---

## 🎯 TIPS PARA LA PRESENTACIÓN

### Antes de empezar:
- [ ] Tener el dashboard abierto en: https://zapallo.shinyapps.io/congestion-santiago-ml/ (o ejecutar `app_olimpiadas.R` localmente)
- [ ] Probar los botones "← Anterior" y "Siguiente →" para navegación fluida
- [ ] Tener el código abierto en VSCode por si hay preguntas técnicas

### Durante la presentación:
- Usar los botones de navegación del sidebar para cambiar de pestaña fluidamente
- Hacer zoom en los gráficos interactivos para destacar puntos importantes
- Aprovechar los tooltips de Plotly para mostrar valores exactos

### Para las preguntas:
- **Javier:** Preguntas sobre teoría, algoritmos, metodología
- **Uriel:** Preguntas sobre resultados, conclusiones, código

### Si algo falla:
- Backup local: `Rscript -e "shiny::runApp('app_olimpiadas.R')"`
- Screenshots en carpeta de respaldo

---

## 🚀 COMANDO PARA EJECUTAR

```r
# Opción 1: Ejecutar localmente
Rscript -e "shiny::runApp('app_olimpiadas.R', launch.browser = TRUE)"

# Opción 2: Desplegar a ShinyApps.io
rsconnect::deployApp(appDir = ".", appPrimaryDoc = "app_olimpiadas.R", appName = "olimpiadas-congestion-ml")
```

---

**¡Éxito en la presentación final! 🏆**
