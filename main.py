import streamlit as st
import mysql.connector as _mysql_connector
import pandas as pd

def create_connection(user: str, password: str, host: str, port: int, database: str):
    """Create a connection to the MySQL database."""
    config = {
        'user': user,
        'password': password,
        'host': host,
        'port': port,
        'database': database
    }
    db = _mysql_connector.connect(**config)
    return db

def get_student(db, student_id: str, semester: str, year: str):
    """Get the data of a student from the database."""
    query = f"""
    SELECT st.student_name AS 'Student Name', 
    st.roll_number AS 'Roll Number', 
    st.department AS 'Department', 
    s.semester AS 'Semester', 
    s.sem_year AS 'Year', 
    sc.spi AS 'SPI', 
    sc.cpi AS 'CPI'
    FROM spi_cpi sc
    JOIN students st ON sc.roll_number = st.roll_number
    JOIN semesters s ON sc.semester_id = s.semester_id
    WHERE st.roll_number = '{student_id}' 
    AND s.semester = '{semester}' 
    AND s.sem_year = '{year}';
    """
    cursor = db.cursor()
    cursor.execute(query)
    student = cursor.fetchall()
    return student

def get_transcript(db, student_id: str, semester: str, year: str):
    """Get the transcript of a student from the database."""
    query = f"""
    SELECT c.course_code AS 'Course Code', 
    c.course_name AS 'Course Name', 
    c.course_credits AS 'Course Credits', 
    e.grade AS 'Grade Obtained'
    FROM enrollments e
    JOIN courses c ON e.course_code = c.course_code
    JOIN semesters s ON e.semester_id = s.semester_id
    WHERE e.roll_number = '{student_id}' 
    AND s.semester = '{semester}' 
    AND s.sem_year = '{year}';
    """
    cursor = db.cursor()
    cursor.execute(query)
    transcript = cursor.fetchall()
    return transcript


def main():
    
    st.set_page_config(page_title="Transcript Generator", page_icon=":scroll:")
    st.title("Generate your Transcript")
    
    with st.sidebar:
        st.subheader("Database Configuration")
        st.write("This is a simple chat application using MySQL. Connect to the database and generate your Transcript.")
        
        st.text_input("Host", value="localhost", key="Host")
        st.text_input("Port", value=3306, key="Port")
        st.text_input("User", value="root", key="User")
        st.text_input("Password", type="password", value="rohit", key="Password")
        st.text_input("Database", value="stud_transcript", key="Database")
        
        if st.button("Connect"):
            with st.spinner("Connecting to database..."):
                db = create_connection(
                    st.session_state["User"],
                    st.session_state["Password"],
                    st.session_state["Host"],
                    st.session_state["Port"],
                    st.session_state["Database"]
                )
                st.session_state.db = db
                st.success("Connected to database!")
        
    st.write("Enter your details to generate the transcript:")
    col1, col2, col3 = st.columns(3)
    with col1:
        student_id = st.text_input("Roll Number", key="Roll Number")
    with col2:
        semester = st.text_input("Semester (Spring/Autumn)", key="Semester")
    with col3:
        year = st.text_input("Year", key="Year")
    if st.button("Generate Transcript"):
        if not st.session_state.get("db"):
            st.error("Please connect to the database first!")
        with st.spinner("Fetching your transcript..."):
            student = get_student(st.session_state.db, student_id, semester, year)
            transcript = get_transcript(st.session_state.db, student_id, semester, year)
            if student and transcript:
                st.success("Transcript generated successfully!")
                st.write("Student Details:")
                student_df = pd.DataFrame(student, columns=['Student Name', 'Roll Number', 'Department', 'Semester', 'Year', 'SPI', 'CPI'])
                st.dataframe(student_df)
                st.write("Transcript:")
                transcript_df = pd.DataFrame(transcript, columns=['Course Code', 'Course Name', 'Course Credits', 'Grade Obtained'])
                st.dataframe(transcript_df)
            else:
                if not student_id or not semester or not year:
                    st.error("Please enter your details!")
                else:
                    st.error("No data found for the given details. Please check and try again.")

if __name__ == "__main__":
    main()