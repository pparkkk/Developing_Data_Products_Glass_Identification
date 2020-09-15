library(shiny)

shinyUI(fluidPage(

    # Application title
    titlePanel("Glass Identification Data"),

    # Main panel = tab
    tabsetPanel(
        # Documentation of the app and data
        tabPanel("Welcome to Glass Identification",
            tags$body(h3("Executive Summary"), br(),
                   "This is the final course project of the", em("Developing Data
                    Products"), "Course, the fourth course in the", em("Statistics
                    and Machine Learning"), "Specialization, taught in Coursera.", 
                   br(), br(),
                   "The application attempts to fit a", strong("random forest"),
                   "machine learning algorithm in order to predict the types of 
                   glass based on their physical (refractive index) and chemical 
                   properties (oxides composition). In addition, it allows users 
                   to manipulate each of the characteristics of the glass (both 
                   refractive index and oxides composition) and tries to predict 
                   the glass type based on data provided by the data set.", br(), 
                   br(), br(), h3("Glass {mlbench}"), br(),
                   "The data set is obtained from the", em("mlbench"), "package
                   in R. It is, according to the documentation,", br(), 
                   tags$blockquote(
                       "A data frame with 214 observation containing examples of 
                       the chemical analysis of 7 different types of glass. The 
                       problem is to forecast the type of class on basis of the 
                       chemical analysis. The study of classification of types of 
                       glass was motivated by criminological investigation. At 
                       the scene of the crime, the glass left can be used as 
                       evidence (if it is correctly identified!)."), 
                   "It consists of the following 10 variables:", br(),
                   "RI = Refractive Index", br(),
                   "Na = Sodium", br(),
                   "Mg = Magnesium", br(),
                   "Al = Aluminium", br(),
                   "Si = Silicon", br(),
                   "K = Potassium", br(),
                   "Ca = Calcium", br(),
                   "Ba = Barium", br(),
                   "Fe = Iron", br(),
                   "Type = 6 Types of glass (1,2,3,5,6,7)", br(),
                   tags$blockquote("1 -- building_windows_float_processed", br(), 
                                   "2 -- building_windows_non_float_processed", br(), 
                                   "3 -- vehicle_windows_float_processed ", br(),
                                   "4 -- vehicle_windows_non_float_processed 
                                   (none in this database)", br(), 
                                   "5 -- containers", br(), 
                                   "6 -- tableware", br(), 
                                   "7 -- headlamps"), br(),
                   em("Note that each of the chemical elements are expressed as 
                   the weight percentage in corresponding oxide out of the total
                   weight of the glass."), "For example, values in the Na column
                   is the weight percentage of sodium oxide in the glasses.", br(),
                   h6("*The data have been taken from the UCI Repository Of Machine 
                      Learning and were converted to R format by Friedrich Leisch.*")
            )
        ),
        
        # output page
        tabPanel("Glass Identification",
            sidebarLayout(
                # inputs
                sidebarPanel(
                    h3("Instructions"), br(), "Slide the following sliders to 
                    make your ideal glass composition and click the submit button. 
                    See what class is your ideal glass lies on the main panel. 
                    You may have to wait a bit whilst the algorithm runs.",
                    br(), br(),
                   sliderInput("ri", "Choose you refractive index",
                        min = 1.512, max = 1.533, value = 1.52, step = 0.001),
                   sliderInput("Na", "Slide for sodium composition",
                        min = 12, max = 16, value = 13, step = 0.5),
                   sliderInput("Mg", "Next, magnesium composition",
                        min = 0, max = 4, value = 3.5, step = 0.5),
                   sliderInput("Al", "What about aluminium?",
                        min = 0.5, max = 3, value = 1.5, step = 0.5),
                   sliderInput("Si", "This is important! - Silicon",
                        min = 70, max = 74, value = 73, step = 0.5),
                   sliderInput("K", "It's time for Potassium!",
                        min = 0, max = 2, value = 0.5, step = 0.25),
                   sliderInput("Ca", "Calcium's turn!", 
                        min = 6, max = 14, value = 8.5, step = 1),
                   sliderInput("Ba", "Last but not least: barium",
                        min = 0, max = 2, value = 0, step = 0.25),
                   sliderInput("Fe", "Finally, iron!",
                        min = 0, max = 0.4, value = 0, step = 0.05),
                   submitButton("Classify My Glass!")
                ),
                mainPanel(h4("Here is the predicted glass type for the original
                Glass data set:"), br(),tableOutput("table"), br(), br(),
                h4("Its accuracy is:"), textOutput("accuracy"), br(), br(),
                h4("Finally, your forecasted glass type!"), br(),
                textOutput("prediction"), br()
                )
            )
        )
    ))
)


