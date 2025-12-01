# GUIÓN DE PRESENTACIÓN - MINERÍA DE DATOS 2025

## Autor
- **Javier Farías**

Universidad Andrés Bello - Ingeniería Civil Informática

---

## ESTRUCTURA DE LA PRESENTACIÓN
---

## 📋 ORDEN DE PESTAÑAS

### 1. 🏠 INICIO (~1 minuto)
- Saludar y presentarse
- Describir brevemente el proyecto: "Predicción de congestión vehicular en Santiago usando Machine Learning"
- Destacar los 3 KPIs: 10,000 observaciones, 5 algoritmos, K-NN ganador

**Qué decir:**
> "Buenos días. Soy Javier Farías, estudiante de Ingeniería Civil Informática de la Universidad Andrés Bello. Hoy presento mi proyecto de minería de datos: un análisis de Machine Learning para predecir la duración de congestión vehicular en Santiago."

---

### 2. 📚 MARCO TEÓRICO (~2 minutos)
- Explicar qué es el aprendizaje supervisado (datos etiquetados)
- Diferencia entre clasificación y regresión
- Describir los 5 algoritmos utilizados brevemente
- Mencionar que K-NN fue el ganador

**Qué decir:**
> "El aprendizaje supervisado entrena modelos con datos etiquetados. Puede ser clasificación para categorías o regresión para valores continuos. Usé regresión porque predigo horas de congestión. Comparé 5 algoritmos: regresión lineal, árboles de decisión, redes neuronales, SVM y K-NN."

---

### 3. 🎯 OBJETIVOS Y VARIABLES (~1.5 minutos)
- Objetivo: predecir duración de congestión con precisión
- Variable dependiente: Duration_hrs (118 valores únicos)
- Variables independientes: geográficas, infraestructura, tráfico
- Justificación de REGRESIÓN: variable continua

**Qué decir:**
> "Mi objetivo es predecir la duración de congestión. La variable objetivo es Duration_hrs con 118 valores únicos, por eso elegí regresión. Usé 24 features incluyendo longitud del trayecto, comuna y coordenadas."

---

### 4. ⏱️ TIEMPOS DE ENTRENAMIENTO (~1 minuto)
- Mostrar los 3 value boxes (tiempo total, más rápido, más lento)
- Explicar que usé 3-fold cross-validation
- Mencionar que SVM fue el más lento

**Qué decir:**
> "El entrenamiento total tomó aproximadamente 33 segundos. El árbol de decisión fue el más rápido, mientras que SVM fue el más lento debido a su complejidad computacional."

---

### 5. 📈 REGRESIÓN LINEAL (~1 minuto)
- Mostrar tabla de coeficientes
- Explicar interpretación: positivo aumenta, negativo disminuye

**Qué decir:**
> "La regresión lineal permite interpretar los coeficientes. Los valores positivos aumentan la duración de congestión, los negativos la disminuyen."

---

### 6. 🌳 ÁRBOL DE DECISIÓN (~1 minuto)
- Mostrar visualización del árbol
- Explicar que cada nodo es una decisión

**Qué decir:**
> "El árbol de decisión muestra cómo el modelo toma decisiones mediante reglas tipo si-entonces."

---

### 7. 🧠 RED NEURONAL (~1 minuto)
- Mostrar arquitectura de la red
- Explicar las 3 capas: entrada (24), oculta (3-5), salida (1)

**Qué decir:**
> "La red neuronal tiene 24 neuronas de entrada, una capa oculta optimizada por validación cruzada, y una neurona de salida para la predicción."

---

### 8. 📊 COMPARACIÓN DE MODELOS (~1.5 minutos)
- Mostrar gráfico de barras con RMSE
- Destacar que K-NN tiene menor RMSE (0.9348)
- Mostrar tabla con métricas

**Qué decir:**
> "Aquí vemos la comparación de todos los modelos. K-NN obtuvo el mejor RMSE con 0.9348 horas, seguido de cerca por la red neuronal."

---

### 9. ✅ VALIDACIÓN EN TEST (~1.5 minutos)
- Mostrar los 4 value boxes del modelo ganador
- Destacar MAE de 31 minutos como métrica interpretable
- Explicar por qué K-NN ganó

**Qué decir:**
> "Estas métricas fueron calculadas en el conjunto de prueba, datos nunca vistos durante el entrenamiento. K-NN logra un error promedio de 31 minutos. Ganó porque captura patrones locales del tráfico santiaguino."

---

### 10. 📉 ANÁLISIS DE RESIDUALES (~1 minuto)
- Mostrar gráfico de residuales
- Mostrar importancia de variables
- Destacar top 3: Length_km, Commune_Santiago, Longitud

**Qué decir:**
> "Las variables más importantes son la longitud del trayecto, la comuna de Santiago y la coordenada de longitud, lo que tiene sentido geográficamente."

---

### 11. 🏆 CONCLUSIONES (~1.5 minutos)
- Modelo ganador: K-NN con error de 31 minutos
- Variables clave
- Limitaciones y mejoras futuras

**Qué decir:**
> "En conclusión, K-NN es el modelo ganador con un error promedio de 31 minutos. El tráfico de Santiago tiene patrones locales que este algoritmo captura bien. Como mejoras futuras propongo incorporar datos de clima y usar el dataset completo."

---

### 12. 📖 REFERENCIAS (~30 segundos)
- Mencionar las fuentes principales
- Destacar el repositorio de GitHub

**Cierre:**
> "Las referencias incluyen textos clásicos de Machine Learning y datos del Ministerio de Transportes. Todo el código está en GitHub. ¿Tienen preguntas?"

---

## 📋 RESUMEN

| Pestaña | Tiempo |
|---------|--------|
| 🏠 Inicio | ~1 min |
| 📚 Marco Teórico | ~2 min |
| 🎯 Objetivos y Variables | ~1.5 min |
| ⏱️ Tiempos | ~1 min |
| 📈 Regresión Lineal | ~1 min |
| 🌳 Árbol de Decisión | ~1 min |
| 🧠 Red Neuronal | ~1 min |
| 📊 Comparación | ~1.5 min |
| ✅ Validación | ~1.5 min |
| 📉 Residuales | ~1 min |
| 🏆 Conclusiones | ~1.5 min |
| 📖 Referencias | ~0.5 min |

**Total: ~13 minutos**

---

## 🚀 COMANDO PARA EJECUTAR LOCALMENTE

```r
Rscript -e "shiny::runApp('app.R', launch.browser = TRUE)"
```

---

