  /* 1- Get a list of all books, including the author's names
     (duplicate books are okay, if the book has multiple authors).*/
     SELECT title, CONCAT (au.first_name," ", au.last_name) 
     FROM books b
     JOIN authorship a
         ON a.book_id = b.book_id
     JOIN authors au
         ON a.author_id = au.author_id
  
  
  /* 2- Get a list of all books withdrawn by people 
     with the initials 'B.W.'. Show a column for the first name, 
     last name, initials, and the title of the book. Remember: 
     keep things concise*/
  
  
     /*example//
      * SELECT title, b.book_id FROM books b
     LEFT JOIN withdrawals w 
       ON b.book_id = w.book_id 
       WHERE w.book_id IS NULL// */
      
      SELECT m.first_name, m.last_name, 
      CONCAT(SUBSTR(m.first_name,1,1),".",
      SUBSTR(m.last_name,1,1),".") AS initial ,title FROM books b
      JOIN withdrawals w
          ON b.book_id = w.book_id 
      JOIN members m 
          ON m.member_id = w.member_id 
      WHERE CONCAT(SUBSTR(m.first_name,1,1),".",
      SUBSTR(m.last_name,1,1),".") = "B.W."
      
 /* 3- Get the number of books written by each American author.
     Include the first and last names of the author.Note that 
     America might be represented in the 'country' column in more
     than one way - always check your results table to make sure
     you're getting the expected results.*/
     
      SELECT a.first_name, a.last_name, COUNT(*) AS "book_total"
      FROM authors a
      JOIN authorship a2 
           ON a.author_id = a2.author_id 
      JOIN books b 
           ON b.book_id = a2.book_id 
      WHERE a.country = "USA" OR a.country = "U.S."
      GROUP BY a.first_name, a.last_name
      
 /*  4- For any book withdrawn in October, get the member's first 
     name, last name, the withdrawal date and the book's title. 
     Hint: Try getting the month from a date using the scalar 
     function MONTH()*/
      
      SELECT m.first_name, m.last_name, w.withdrawal_date, b.title
      FROM withdrawals w
      JOIN members m 
           ON m.member_id = w.member_id 
      JOIN books b 
           ON b.book_id  = w.book_id  
      WHERE MONTH (w.withdrawal_date) = 10
      
  /* 5- Get a list of people who have ever returned overdue books 
     (i.e. any withdrawal where the return date is greater than 
     the due date). Remember that, unless otherwise specified, 
     lists shouldn't contain duplicate rows.*/
      
      SELECT DISTINCT m.first_name, m.last_name 
      FROM members m
      JOIN withdrawals w 
           ON m.member_id = w.member_id 
      WHERE w.return_date > w.due_date 
      
   /* 6- Get a list of all authors, and the books they wrote. 
      Include authors multiple times if they wrote multiple 
      books. Also include authors who don't have any books in 
      the database. Hint: this is a tricky one - think back on 
      why right joins exist in the first place.*/
      
      SELECT a.first_name , a.last_name, title
      FROM books b
      JOIN authorship a2
            ON b.book_id = a2.book_id
      RIGHT JOIN authors a
            ON  a.author_id = a2.author_id     
      
      
     /* 7- Get a list of members who've never withdrawn a book.
        Hint: outer joins return rows with null values if there 
        is no match between the tables.*/
      
        SELECT m.first_name, m.last_name, w.withdrawal_date
        FROM members m
        LEFT JOIN withdrawals w
             ON m.member_id = w.member_id 
        WHERE w.member_id IS NULL 
        
        
      /* 8- Rewrite the above query as the opposite join (if you 
         used a left join, rewrite it as a right join; if you 
         used a right join, rewrite it as a left join). The 
         results table should contain the same data.*/
        
        SELECT m.first_name, m.last_name, w.withdrawal_date
        FROM  withdrawals w
        RIGHT JOIN members m 
              ON m.member_id = w.member_id 
        WHERE w.member_id IS NULL 
        
        /* 9- Cross join books and authors. Isn't that ridiculous*/
        
        SELECT books.book_id, books.title, books.genre,
        authors.author_id, authors.first_name, authors.last_name,
        authors.stateProv, authors.country
        FROM books, authors
        
        
        /* 10- Get a list of all members who have the same first 
           name as other members. Sort it by first name so you can 
           verify the data.*/
        
        SELECT first_name, COUNT(*)  FROM members
        GROUP BY first_name  
        HAVING COUNT(*)>1        