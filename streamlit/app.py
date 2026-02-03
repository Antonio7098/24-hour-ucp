import streamlit as st

st.title("Welcome to Streamlit")


# Session state is like a dictionary that remembers things! 

# First, we need to initialise our counter if it doesn't exist 

if "count" not in st.session_state: 

    st.session_state["count"] = 0 

st.subheader(f"Button pressed: {st.session_state['count']} times") 

if st.button("🎈 Click me!"): 

    st.session_state["count"] = st.session_state["count"] + 1 

    st.balloons() 

st.write(f"Current count: {st.session_state['count']}")

st.markdown("This is **Streamlit**")

name = st.text_input("What is your name?", placeholder="")

st.header("HEader")

st.write("---")

col1, col2, col3 = st.columns(3)

with col1:
    st.header("Column 1")

with col3:
    st.header("Column 2")

st.sidebar.title("Sidebar")

st.sidebar.write("This is in the sidebar")

