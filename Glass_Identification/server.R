library(shiny)

library(mlbench); library(caret); library(randomForest); library(e1071)
data(Glass)

set.seed(418801)
newrow <- sample(1:nrow(Glass), size = 1000, replace = TRUE)
newdata <- Glass[newrow, ]
fitrf <- train(Type ~ ., data = newdata, method = "rf", ntree = 100)
predrf <- predict(fitrf, newdata = Glass)
acc <- confusionMatrix(predrf, Glass$Type)
result <- data.frame(Prediction = c(1L, 2L, 3L, 5L, 6L, 7L),
                     Reference.1 = rep(NA, 6),
                     Reference.2 = rep(NA,6),
                     Reference.3 = rep(NA,6),
                     Reference.5 = rep(NA, 6),
                     Reference.6 = rep(NA,6),
                     Reference.7 = rep(NA,6))
for (i in 1:6) {
    result[i,2:7] <- acc$table[i,]
}

description <- data.frame(Type = c(1,2,3,5,6,7),
                          Description = c("building windows float processed",
                                          "buildin windows non float processed",
                                          "vehicle windows float processed",
                                          "containers", "tableware", "headlamps"))

shinyServer(function(input, output) {
        ri <- reactive({input$ri})
        na <- reactive({input$Na})
        mg <- reactive({input$Mg})
        al <- reactive({input$Al})
        si <- reactive({input$Si})
        k  <- reactive({input$K})
        ca <- reactive({input$Ca})
        ba <- reactive({input$Ba})
        fe <- reactive({input$Fe})
        
        inputdata <- reactive({
            data.frame(RI = ri(), Na = na(), Mg = mg(), Al = al(), Si = si(),
                       K = k(), Ca = ca(), Ba = ba(), Fe = fe())
        })
        
        # output table
        output$table <- renderTable({
            result
        })
        
        # output accuracy
        output$accuracy <- renderText({
            paste(acc$overall[1]*100, "percent")
        })
        
        # output prediction
        output$prediction <- renderText({
            glasstype <- predict(fitrf, newdata = inputdata())
            explain <- description[grep(glasstype, description),2]
            paste(glasstype, ":", " ", explain)
        })

})
