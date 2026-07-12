<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="UserDeshboard.aspx.cs" Inherits="WebApplicationFailDataDemo.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        html, body {
            height: 100%;
            margin: 0;
            overflow: hidden;
        }

        /* Slideshow background container */
        .slideshow-bg {
            position: fixed;
            top: 0px;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -2; /* behind everything */
        }

        /* All slides */
        .slide {
     position: absolute;
     width: 100%;
     height: 100%;
     background-size: cover; /* cover the screen completely */
     background-position: center center; /* center image */
     background-repeat: no-repeat;
     opacity: 0;
     transition: opacity 1.5s ease-in-out;
 }

            .slide.active {
                opacity: 1;
            }

        /* Overlay for readability */
        .overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 107%;
            background-color: rgba(0,0,0,0.3);
            z-index: -1; /* behind navbar and content */
        }

        /* Content styling */
        .dashboard-content {
            position: absolute;
            top: 80%;
            left: 30%;
            transform: translate(-50%, -50%);
            z-index: 2; /* above background & overlay */
            text-align: left;
            padding: 20px;
            /* Text color options */
            color:lightskyblue; /* gold color */
            /* color: rgb(255, 215, 0); same as gold */
            /* color: rgba(255, 215, 0, 0.9); gold with 90% opacity */
        }


        h2 {
            font-size: 40px;
            margin-bottom: 20px;
        }

        p {
            font-size: 18px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Slideshow Background -->
    <div class="slideshow-bg">
        <div class="slide active" style="background-image: url('<%= ResolveUrl("~/image/new06.jpg") %>');"></div>
        <div class="slide" style="background-image: url('<%= ResolveUrl("~/image/aa12.jpeg") %>');"></div>
        <div class="slide" style="background-image: url('<%= ResolveUrl("~/image/new03.jpg") %>');"></div>
        <div class="slide" style="background-image: url('<%= ResolveUrl("~/image/new02.jpg") %>');"></div>
        <div class="slide" style="background-image: url('<%= ResolveUrl("~/image/new05.jpg") %>');"></div>
    </div>

    <div class="overlay"></div>

    <div class="dashboard-content">
        
    </div>

    <script>
        // JavaScript to rotate slides
        const slides = document.querySelectorAll('.slide');
        let current = 0;

        setInterval(() => {
            slides[current].classList.remove('active');
            current = (current + 1) % slides.length;
            slides[current].classList.add('active');
        }, 5000); // Change image every 5 seconds
    </script>
</asp:Content>
