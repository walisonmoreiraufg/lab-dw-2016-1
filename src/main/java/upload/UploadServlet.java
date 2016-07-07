package upload;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

@WebServlet(value = "/upload")
public class UploadServlet extends HttpServlet {

  protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    String method = req.getMethod();

    if (method.equals("POST")) {
      boolean isMultipart = ServletFileUpload.isMultipartContent(req);

      if (isMultipart) {
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        try {
          List items = upload.parseRequest(req);
          Iterator iterator = items.iterator();
          while (iterator.hasNext()) {
            FileItem item = (FileItem) iterator.next();

            if (!item.isFormField()) {
              String fileName = item.getName();
              
              fileName = "foto.jpg";

              String root = getServletContext().getRealPath("/");
              File path = new File(root + "/arquivos");
              if (!path.exists()) {
                boolean status = path.mkdirs();
              }

              File uploadedFile = new File(path + "/" + fileName);
              System.out.println(uploadedFile.getAbsolutePath());
              item.write(uploadedFile);
            }
          }
        } catch (FileUploadException e) {
          e.printStackTrace();
        } catch (Exception e) {
          e.printStackTrace();
        }
      }
    }
    // Redirecionar a requisição para uma página HTML.
    resp.sendRedirect("upload.html");
  }

}
