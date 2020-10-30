import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.List;

public class UploadUserHeadServlet extends HttpServlet {

    // 参考这篇文章：https://blog.csdn.net/ITBigGod/article/details/79780601
    private static final String UploadUserHead_DIRECTORY = "E:\\大三上\\FourNew\\web\\HTMLImage\\userHead";
    private static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;
    private static final int MAX_FILE_SIZE = 1024 * 1024 * 40;
    private static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!ServletFileUpload.isMultipartContent(req)) {
            PrintWriter writer = resp.getWriter();
            writer.print("Error: 表单必须写有:enctypr=multipart/form-data");
            writer.flush();
            return;
        }
        String id = req.getParameter("id");
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);

        upload.setFileSizeMax(MAX_FILE_SIZE);

        upload.setSizeMax(MAX_REQUEST_SIZE);

        upload.setHeaderEncoding("UTF-8");

        String uploadPath = UploadUserHead_DIRECTORY;

        File uploadDIR = new File(uploadPath);
        if (!uploadDIR.exists()) {
            uploadDIR.mkdir();
        }

        try {
            List<FileItem> formItems = upload.parseRequest(req);


            File file = new File(URLDecoder.decode(UploadUserHead_DIRECTORY,"utf-8"));
            File[] tempList = file.listFiles();
            String originPath = "";
            for (File f:tempList) {
                if(f.isFile()&&f.getName().startsWith(id)){
                    originPath = f.getName();
                }
            }

            if (formItems != null && formItems.size() > 0) {
                for (FileItem item : formItems) {
                    if (!item.isFormField()) {
                        String originFileName = new File(item.getName()).getName();
                        System.out.println("文件的名字:" + originFileName);
                        String fileName = id+originFileName.substring(originFileName.indexOf('.'));
                        String filePath = uploadPath + File.separator + fileName;
                        System.out.println("文件保存的位置:" + filePath);
                        System.out.println("filename="+fileName);

                        // 删除原来的文件
                        File orgin = new File(uploadPath+File.separator +originPath);
                        if(orgin.delete()){
                            System.out.println("原始头像删除成功");
                        }else {
                            System.out.println("原始头像删除失败");
                        }
                        File storeFile = new File(filePath);
                        //存储新文件
                        System.out.println("storeFile:"+storeFile);
                        item.write(storeFile);
                        req.setAttribute("message",
                                "文件上传成功!" + "<br>存于:" + filePath);

                    }
                }
            }
        } catch (FileUploadException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            resp.sendRedirect(req.getContextPath()+"/SingleStudent.jsp?id="+id);
        }

    }
}
